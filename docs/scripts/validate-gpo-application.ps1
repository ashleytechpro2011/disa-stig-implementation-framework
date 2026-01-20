<#
.SYNOPSIS
    Validates Group Policy application for STIG compliance enforcement
    
.DESCRIPTION
    Checks GPO application status across domain-joined systems to ensure
    STIG configurations are being applied correctly. Identifies GPO failures,
    conflicts, and systems where policies are not applying as expected.
    
.PARAMETER ComputerName
    Array of computer names to validate. If not specified, validates all domain computers.
    
.PARAMETER GPOName
    Specific GPO to validate. If not specified, checks all STIG-related GPOs.
    
.PARAMETER OutputPath
    Directory where validation reports will be saved
    
.EXAMPLE
    .\validate-gpo-application.ps1 -GPOName "STIG_Windows11_v1r5" -OutputPath "C:\Reports"
    
.EXAMPLE
    .\validate-gpo-application.ps1 -ComputerName @("SERVER01","SERVER02")
    
.NOTES
    Author: ISSO Security Team
    Version: 1.0
    Requires: Active Directory PowerShell Module, Domain Admin or equivalent permissions
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string[]]$ComputerName,
    
    [Parameter(Mandatory=$false)]
    [string]$GPOName,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputPath = "C:\GPO-Reports"
)

# Import required modules
Import-Module ActiveDirectory -ErrorAction Stop
Import-Module GroupPolicy -ErrorAction Stop

$DateStamp = Get-Date -Format "yyyyMMdd_HHmmss"
$LogFile = "$OutputPath\gpo-validation_$DateStamp.txt"

#region Functions

function Write-Log {
    param([string]$Message, [string]$Level="INFO")
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$Level] $Message"
    
    if (-not (Test-Path $OutputPath)) {
        New-Item -Path $OutputPath -ItemType Directory -Force | Out-Null
    }
    
    Add-Content -Path $LogFile -Value $logMessage
    
    switch ($Level) {
        "ERROR" { Write-Host $logMessage -ForegroundColor Red }
        "WARNING" { Write-Host $logMessage -ForegroundColor Yellow }
        "SUCCESS" { Write-Host $logMessage -ForegroundColor Green }
        default { Write-Host $logMessage }
    }
}

function Get-STIGGPOs {
    Write-Log "Retrieving STIG-related GPOs..."
    
    if ($GPOName) {
        $gpos = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
        if (-not $gpos) {
            Write-Log "GPO '$GPOName' not found" "ERROR"
            return @()
        }
        return @($gpos)
    } else {
        # Get all GPOs with "STIG" in the name
        $allGPOs = Get-GPO -All
        $stigGPOs = $allGPOs | Where-Object { $_.DisplayName -like "*STIG*" }
        
        Write-Log "Found $($stigGPOs.Count) STIG-related GPOs" "SUCCESS"
        return $stigGPOs
    }
}

function Get-TargetComputers {
    Write-Log "Identifying target computers..."
    
    if ($ComputerName) {
        Write-Log "Using specified computers: $($ComputerName -join ', ')"
        return $ComputerName
    } else {
        # Get all domain computers
        $computers = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name
        Write-Log "Found $($computers.Count) domain computers" "SUCCESS"
        return $computers
    }
}

function Test-GPOApplication {
    param(
        [string]$Computer,
        [string]$GPO
    )
    
    try {
        # Test if computer is online
        if (-not (Test-Connection -ComputerName $Computer -Count 1 -Quiet)) {
            return @{
                ComputerName = $Computer
                GPOName = $GPO
                Status = "Offline"
                LastApplied = $null
                Error = "Computer not reachable"
            }
        }
        
        # Get GPO application status using gpresult
        $scriptBlock = {
            param($GPODisplayName)
            
            # Generate HTML report
            $tempFile = "$env:TEMP\gpresult_$(Get-Date -Format 'yyyyMMddHHmmss').html"
            gpresult /H $tempFile /F | Out-Null
            
            if (Test-Path $tempFile) {
                $content = Get-Content $tempFile -Raw
                Remove-Item $tempFile -Force
                
                # Check if GPO is mentioned in the report
                if ($content -match $GPODisplayName) {
                    # Extract last applied time (simplified - actual parsing would be more complex)
                    if ($content -match "Last time Group Policy was applied: (.+?)<") {
                        return @{
                            Applied = $true
                            LastApplied = $matches[1]
                        }
                    }
                    return @{
                        Applied = $true
                        LastApplied = "Unknown"
                    }
                } else {
                    return @{
                        Applied = $false
                        LastApplied = $null
                    }
                }
            }
            
            return @{
                Applied = $false
                LastApplied = $null
            }
        }
        
        $result = Invoke-Command -ComputerName $Computer -ScriptBlock $scriptBlock -ArgumentList $GPO -ErrorAction Stop
        
        return @{
            ComputerName = $Computer
            GPOName = $GPO
            Status = if ($result.Applied) { "Applied" } else { "Not Applied" }
            LastApplied = $result.LastApplied
            Error = $null
        }
        
    }
    catch {
        return @{
            ComputerName = $Computer
            GPOName = $GPO
            Status = "Error"
            LastApplied = $null
            Error = $_.Exception.Message
        }
    }
}

function Get-GPOEventLogs {
    param(
        [string]$Computer
    )
    
    try {
        if (-not (Test-Connection -ComputerName $Computer -Count 1 -Quiet)) {
            return @()
        }
        
        # Get Group Policy event logs from the last 24 hours
        $startTime = (Get-Date).AddDays(-1)
        
        $events = Get-WinEvent -ComputerName $Computer -FilterHashtable @{
            LogName = 'Microsoft-Windows-GroupPolicy/Operational'
            StartTime = $startTime
        } -MaxEvents 100 -ErrorAction SilentlyContinue
        
        return $events
    }
    catch {
        Write-Log "Could not retrieve event logs from $Computer" "WARNING"
        return @()
    }
}

function Test-GPOHealth {
    param([string]$Computer)
    
    Write-Log "Checking GPO health on $Computer..."
    
    $healthStatus = @{
        ComputerName = $Computer
        Reachable = $false
        GPUpdateSuccess = $false
        Errors = @()
        Warnings = @()
    }
    
    # Test connectivity
    if (Test-Connection -ComputerName $Computer -Count 1 -Quiet) {
        $healthStatus.Reachable = $true
        
        # Get event logs
        $events = Get-GPOEventLogs -Computer $Computer
        
        # Check for errors (Event ID 1096 = Processing failed)
        $errors = $events | Where-Object { $_.Id -eq 1096 }
        if ($errors) {
            $healthStatus.Errors += "GPO processing failures detected"
            $healthStatus.GPUpdateSuccess = $false
        }
        
        # Check for successful processing (Event ID 1502 = Processing succeeded)
        $success = $events | Where-Object { $_.Id -eq 1502 }
        if ($success) {
            $healthStatus.GPUpdateSuccess = $true
        }
        
        # Check for warnings
        $warnings = $events | Where-Object { $_.Level -eq 3 }  # Warning level
        if ($warnings) {
            $healthStatus.Warnings += "$($warnings.Count) warning(s) in GPO event log"
        }
    }
    
    return $healthStatus
}

#endregion

#region Main Execution

Write-Log "========================================" "INFO"
Write-Log "GPO Application Validation - Started" "INFO"
Write-Log "========================================" "INFO"

# Get STIG GPOs to validate
$stigGPOs = Get-STIGGPOs
if ($stigGPOs.Count -eq 0) {
    Write-Log "No STIG GPOs found to validate" "ERROR"
    exit 1
}

# Get target computers
$computers = Get-TargetComputers

Write-Log "Validating $($stigGPOs.Count) GPO(s) across $($computers.Count) computer(s)..." "INFO"

# Initialize results
$validationResults = @()
$healthResults = @()

# Validate each GPO on each computer
$totalChecks = $stigGPOs.Count * $computers.Count
$currentCheck = 0

foreach ($gpo in $stigGPOs) {
    Write-Log "----------------------------------------" "INFO"
    Write-Log "Validating GPO: $($gpo.DisplayName)" "INFO"
    
    foreach ($comp in $computers) {
        $currentCheck++
        Write-Progress -Activity "Validating GPO Application" `
            -Status "Checking $comp for $($gpo.DisplayName)" `
            -PercentComplete (($currentCheck / $totalChecks) * 100)
        
        $result = Test-GPOApplication -Computer $comp -GPO $gpo.DisplayName
        $validationResults += $result
        
        if ($result.Status -eq "Applied") {
            Write-Log "$comp - GPO applied successfully (Last: $($result.LastApplied))" "SUCCESS"
        } elseif ($result.Status -eq "Not Applied") {
            Write-Log "$comp - GPO NOT applied" "ERROR"
        } else {
            Write-Log "$comp - $($result.Status): $($result.Error)" "WARNING"
        }
    }
}

Write-Progress -Activity "Validating GPO Application" -Completed

# Check GPO health on sample of systems
Write-Log "----------------------------------------" "INFO"
Write-Log "Checking GPO health on systems..." "INFO"

$sampleSize = [Math]::Min(10, $computers.Count)
$sampleComputers = $computers | Get-Random -Count $sampleSize

foreach ($comp in $sampleComputers) {
    $health = Test-GPOHealth -Computer $comp
    $healthResults += $health
    
    if ($health.Reachable) {
        if ($health.GPUpdateSuccess) {
            Write-Log "$comp - GPO processing healthy" "SUCCESS"
        } else {
            Write-Log "$comp - GPO processing issues detected" "WARNING"
        }
        
        if ($health.Errors.Count -gt 0) {
            foreach ($error in $health.Errors) {
                Write-Log "  ERROR: $error" "ERROR"
            }
        }
    } else {
        Write-Log "$comp - Not reachable for health check" "WARNING"
    }
}

# Generate summary statistics
Write-Log "========================================" "INFO"
Write-Log "Validation Summary" "INFO"
Write-Log "========================================" "INFO"

$totalValidations = $validationResults.Count
$applied = ($validationResults | Where-Object { $_.Status -eq "Applied" }).Count
$notApplied = ($validationResults | Where-Object { $_.Status -eq "Not Applied" }).Count
$offline = ($validationResults | Where-Object { $_.Status -eq "Offline" }).Count
$errors = ($validationResults | Where-Object { $_.Status -eq "Error" }).Count

Write-Log "Total Validations: $totalValidations" "INFO"
Write-Log "Successfully Applied: $applied ($([math]::Round(($applied/$totalValidations)*100,2))%)" "SUCCESS"
Write-Log "Not Applied: $notApplied" "ERROR"
Write-Log "Offline Systems: $offline" "WARNING"
Write-Log "Errors: $errors" "ERROR"

# Export detailed results
$csvPath = "$OutputPath\gpo-validation-results_$DateStamp.csv"
$validationResults | Export-Csv -Path $csvPath -NoTypeInformation
Write-Log "Detailed results exported to: $csvPath" "SUCCESS"

$healthCsvPath = "$OutputPath\gpo-health-check_$DateStamp.csv"
$healthResults | Export-Csv -Path $healthCsvPath -NoTypeInformation
Write-Log "Health check results exported to: $healthCsvPath" "SUCCESS"

# Identify systems requiring attention
$problemSystems = $validationResults | Where-Object { 
    $_.Status -ne "Applied" -and $_.Status -ne "Offline" 
}

if ($problemSystems.Count -gt 0) {
    Write-Log "========================================" "WARNING"
    Write-Log "Systems Requiring Attention: $($problemSystems.Count)" "WARNING"
    Write-Log "========================================" "WARNING"
    
    $problemCsvPath = "$OutputPath\gpo-issues_$DateStamp.csv"
    $problemSystems | Export-Csv -Path $problemCsvPath -NoTypeInformation
    Write-Log "Problem systems list: $problemCsvPath" "WARNING"
    
    foreach ($system in ($problemSystems | Select-Object -First 5)) {
        Write-Log "$($system.ComputerName) - $($system.GPOName): $($system.Error)" "WARNING"
    }
    
    if ($problemSystems.Count -gt 5) {
        Write-Log "... and $($problemSystems.Count - 5) more. See CSV for full list." "WARNING"
    }
}

Write-Log "========================================" "INFO"
Write-Log "GPO Application Validation - Completed" "INFO"
Write-Log "========================================" "INFO"

# Return exit code based on results
if ($notApplied -eq 0 -and $errors -eq 0) {
    exit 0
} else {
    exit 1
}

#endregion
