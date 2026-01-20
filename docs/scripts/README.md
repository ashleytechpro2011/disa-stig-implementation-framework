<#
.SYNOPSIS
    Automated SCAP scanning script for enterprise STIG compliance validation
    
.DESCRIPTION
    Executes SCAP Compliance Checker (SCC) scans across multiple systems,
    organizes results, and generates compliance metrics. Designed for DoD
    environments running continuous STIG compliance monitoring.
    
.PARAMETER TargetSystems
    Array of computer names or IP addresses to scan
    
.PARAMETER ScanProfile
    STIG profile to use (Windows11, RHEL8, etc.)
    
.PARAMETER OutputPath
    Directory where scan results will be saved
    
.PARAMETER Credential
    PSCredential object for authenticated scanning
    
.EXAMPLE
    .\execute-scap-scan.ps1 -TargetSystems @("SERVER01","SERVER02") -ScanProfile "Windows_Server_2022" -OutputPath "C:\SCAP\Results"
    
.NOTES
    Author: ISSO Security Team
    Version: 1.0
    Requires: SCAP Compliance Checker (SCC) installed
    Location: C:\Program Files\SCAP\SCC\
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string[]]$TargetSystems,
    
    [Parameter(Mandatory=$true)]
    [ValidateSet("Windows_11","Windows_Server_2022","RHEL_8","RHEL_9")]
    [string]$ScanProfile,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputPath = "C:\SCAP\Results",
    
    [Parameter(Mandatory=$false)]
    [PSCredential]$Credential
)

# Configuration
$SCCPath = "C:\Program Files\SCAP\SCC\cscc.exe"
$BenchmarkPath = "C:\SCAP\Benchmarks"
$DateStamp = Get-Date -Format "yyyyMMdd_HHmmss"
$LogFile = "$OutputPath\scan-log_$DateStamp.txt"

# Benchmark mapping
$BenchmarkMap = @{
    "Windows_11" = "$BenchmarkPath\U_MS_Windows_11_V1R5_STIG_SCAP_1-2_Benchmark.xml"
    "Windows_Server_2022" = "$BenchmarkPath\U_MS_Windows_Server_2022_V1R3_STIG_SCAP_1-2_Benchmark.xml"
    "RHEL_8" = "$BenchmarkPath\U_RHEL_8_V1R9_STIG_SCAP_1-2_Benchmark.xml"
    "RHEL_9" = "$BenchmarkPath\U_RHEL_9_V1R1_STIG_SCAP_1-2_Benchmark.xml"
}

#region Functions

function Write-Log {
    param([string]$Message, [string]$Level="INFO")
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$Level] $Message"
    
    Add-Content -Path $LogFile -Value $logMessage
    
    switch ($Level) {
        "ERROR" { Write-Host $logMessage -ForegroundColor Red }
        "WARNING" { Write-Host $logMessage -ForegroundColor Yellow }
        "SUCCESS" { Write-Host $logMessage -ForegroundColor Green }
        default { Write-Host $logMessage }
    }
}

function Test-Prerequisites {
    Write-Log "Checking prerequisites..."
    
    # Check if SCC is installed
    if (-not (Test-Path $SCCPath)) {
        Write-Log "SCAP Compliance Checker not found at $SCCPath" "ERROR"
        Write-Log "Please install SCC from https://public.cyber.mil/stigs/scap/" "ERROR"
        return $false
    }
    
    # Check if benchmark exists
    $benchmark = $BenchmarkMap[$ScanProfile]
    if (-not (Test-Path $benchmark)) {
        Write-Log "Benchmark not found: $benchmark" "ERROR"
        Write-Log "Please download SCAP benchmarks from https://public.cyber.mil/stigs/" "ERROR"
        return $false
    }
    
    # Create output directory if needed
    if (-not (Test-Path $OutputPath)) {
        New-Item -Path $OutputPath -ItemType Directory -Force | Out-Null
        Write-Log "Created output directory: $OutputPath" "SUCCESS"
    }
    
    Write-Log "Prerequisites check passed" "SUCCESS"
    return $true
}

function Invoke-SCAPScan {
    param(
        [string]$ComputerName,
        [string]$Benchmark,
        [PSCredential]$ScanCredential
    )
    
    Write-Log "Starting SCAP scan on $ComputerName..."
    
    $outputFile = "$OutputPath\${ComputerName}_${ScanProfile}_$DateStamp"
    
    # Build SCC command arguments
    $sccArgs = @(
        "-scap"
        "-content `"$Benchmark`""
        "-output `"$outputFile`""
    )
    
    # Add credential if provided
    if ($ScanCredential) {
        $username = $ScanCredential.UserName
        $password = $ScanCredential.GetNetworkCredential().Password
        $sccArgs += "-cred `"$username`" `"$password`""
    }
    
    # Add target system
    $sccArgs += "-host `"$ComputerName`""
    
    try {
        # Execute SCAP scan
        $process = Start-Process -FilePath $SCCPath -ArgumentList $sccArgs -Wait -PassThru -NoNewWindow
        
        if ($process.ExitCode -eq 0) {
            Write-Log "SCAP scan completed successfully on $ComputerName" "SUCCESS"
            
            # Check if results file was created
            $resultsXML = "$outputFile.xml"
            if (Test-Path $resultsXML) {
                Write-Log "Results saved: $resultsXML" "SUCCESS"
                return @{
                    Success = $true
                    ComputerName = $ComputerName
                    ResultsFile = $resultsXML
                    ExitCode = $process.ExitCode
                }
            } else {
                Write-Log "Results file not found for $ComputerName" "WARNING"
                return @{
                    Success = $false
                    ComputerName = $ComputerName
                    Error = "Results file not created"
                }
            }
        } else {
            Write-Log "SCAP scan failed on $ComputerName with exit code: $($process.ExitCode)" "ERROR"
            return @{
                Success = $false
                ComputerName = $ComputerName
                ExitCode = $process.ExitCode
            }
        }
    }
    catch {
        Write-Log "Exception during SCAP scan on ${ComputerName}: $_" "ERROR"
        return @{
            Success = $false
            ComputerName = $ComputerName
            Error = $_.Exception.Message
        }
    }
}

function Get-ComplianceSummary {
    param([string]$ResultsFile)
    
    try {
        [xml]$results = Get-Content $ResultsFile
        
        # Parse SCAP results (XCCDF format)
        $rules = $results.Benchmark.TestResult.'rule-result'
        
        $pass = ($rules | Where-Object { $_.result -eq 'pass' }).Count
        $fail = ($rules | Where-Object { $_.result -eq 'fail' }).Count
        $notApplicable = ($rules | Where-Object { $_.result -eq 'notapplicable' }).Count
        $notChecked = ($rules | Where-Object { $_.result -eq 'notchecked' }).Count
        $total = $rules.Count
        
        $compliancePercent = if ($total -gt 0) { 
            [math]::Round((($pass + $notApplicable) / $total) * 100, 2) 
        } else { 0 }
        
        return @{
            Total = $total
            Pass = $pass
            Fail = $fail
            NotApplicable = $notApplicable
            NotChecked = $notChecked
            CompliancePercent = $compliancePercent
        }
    }
    catch {
        Write-Log "Error parsing results file: $_" "ERROR"
        return $null
    }
}

#endregion

#region Main Execution

Write-Log "========================================" "INFO"
Write-Log "SCAP Compliance Scan - Started" "INFO"
Write-Log "Profile: $ScanProfile" "INFO"
Write-Log "Target Systems: $($TargetSystems.Count)" "INFO"
Write-Log "========================================" "INFO"

# Check prerequisites
if (-not (Test-Prerequisites)) {
    Write-Log "Prerequisites check failed. Exiting." "ERROR"
    exit 1
}

# Get benchmark path
$benchmark = $BenchmarkMap[$ScanProfile]
Write-Log "Using benchmark: $benchmark" "INFO"

# Initialize results tracking
$scanResults = @()
$successCount = 0
$failCount = 0

# Execute scans on each target system
foreach ($system in $TargetSystems) {
    Write-Log "----------------------------------------" "INFO"
    
    # Test connectivity
    if (Test-Connection -ComputerName $system -Count 1 -Quiet) {
        Write-Log "$system is reachable" "SUCCESS"
        
        # Execute scan
        $result = Invoke-SCAPScan -ComputerName $system -Benchmark $benchmark -ScanCredential $Credential
        $scanResults += $result
        
        if ($result.Success) {
            $successCount++
            
            # Get compliance summary
            $summary = Get-ComplianceSummary -ResultsFile $result.ResultsFile
            if ($summary) {
                Write-Log "Compliance Summary for ${system}:" "INFO"
                Write-Log "  Total Checks: $($summary.Total)" "INFO"
                Write-Log "  Pass: $($summary.Pass)" "SUCCESS"
                Write-Log "  Fail: $($summary.Fail)" "ERROR"
                Write-Log "  Not Applicable: $($summary.NotApplicable)" "INFO"
                Write-Log "  Not Checked: $($summary.NotChecked)" "WARNING"
                Write-Log "  Compliance: $($summary.CompliancePercent)%" "INFO"
            }
        } else {
            $failCount++
        }
    } else {
        Write-Log "$system is not reachable - skipping" "ERROR"
        $failCount++
        $scanResults += @{
            Success = $false
            ComputerName = $system
            Error = "System not reachable"
        }
    }
}

# Generate summary report
Write-Log "========================================" "INFO"
Write-Log "SCAP Compliance Scan - Completed" "INFO"
Write-Log "Total Systems: $($TargetSystems.Count)" "INFO"
Write-Log "Successful Scans: $successCount" "SUCCESS"
Write-Log "Failed Scans: $failCount" "ERROR"
Write-Log "Results Location: $OutputPath" "INFO"
Write-Log "========================================" "INFO"

# Export results to CSV for tracking
$csvPath = "$OutputPath\scan-summary_$DateStamp.csv"
$scanResults | Select-Object ComputerName, Success, ResultsFile, ExitCode, Error | 
    Export-Csv -Path $csvPath -NoTypeInformation

Write-Log "Summary exported to: $csvPath" "SUCCESS"

# Return exit code
if ($failCount -eq 0) {
    exit 0
} else {
    exit 1
}

#endregion
