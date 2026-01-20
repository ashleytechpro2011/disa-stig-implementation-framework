# Automation Scripts

This directory contains production-ready scripts for automating DISA STIG compliance implementation, validation, and continuous monitoring activities.

---

## 📁 Directory Structure

```
scripts/
├── scap-automation/          # SCAP scanning automation
├── gpo-management/           # Group Policy validation and monitoring
├── linux-remediation/        # Linux/UNIX STIG remediation scripts
└── reporting/                # Compliance reporting and metrics
```

---

## 🔧 Available Scripts

### **SCAP Automation** (`scap-automation/`)

#### `execute-scap-scan.ps1`
**Purpose:** Automated SCAP Compliance Checker execution across enterprise systems

**Features:**
- Multi-system scanning with parallel execution support
- Automated result collection and organization
- Compliance summary generation
- Error handling and retry logic
- Detailed logging and reporting

**Usage:**
```powershell
.\execute-scap-scan.ps1 -TargetSystems @("SERVER01","SERVER02") `
                        -ScanProfile "Windows_Server_2022" `
                        -OutputPath "C:\SCAP\Results"
```

**Requirements:**
- SCAP Compliance Checker (SCC) installed
- Current SCAP benchmarks from DISA
- Administrative credentials for target systems
- PowerShell 5.1 or higher

---

### **GPO Management** (`gpo-management/`)

#### `validate-gpo-application.ps1`
**Purpose:** Validates Group Policy application status for STIG enforcement

**Features:**
- Verifies GPO application across domain-joined systems
- Identifies GPO processing failures
- Detects configuration drift
- Event log analysis for troubleshooting
- Generates detailed health reports

**Usage:**
```powershell
.\validate-gpo-application.ps1 -GPOName "STIG_Windows11_v1r5" `
                               -OutputPath "C:\Reports"
```

**Requirements:**
- Active Directory PowerShell module
- Domain Admin or equivalent permissions
- Access to target systems
- PowerShell 5.1 or higher

---

### **Linux Remediation** (`linux-remediation/`)

**Status:** Planned - Scripts coming soon

**Planned Scripts:**
- `rhel8-stig-baseline.sh` - RHEL 8 automated STIG remediation
- `rhel9-stig-baseline.sh` - RHEL 9 automated STIG remediation  
- `ubuntu-stig-baseline.sh` - Ubuntu automated STIG remediation

---

### **Reporting** (`reporting/`)

**Status:** Planned - Scripts coming soon

**Planned Scripts:**
- `generate-compliance-dashboard.ps1` - Real-time compliance visualization
- `emass-prep.ps1` - eMASS artifact organization and preparation
- `poam-status-report.ps1` - Automated POA&M status reporting

---

## 🚀 Getting Started

### Prerequisites

**Windows Systems:**
```powershell
# Install required modules
Install-Module -Name ActiveDirectory
Install-Module -Name GroupPolicy

# Download tools
# SCAP Compliance Checker: https://public.cyber.mil/stigs/scap/
# STIG Viewer: https://public.cyber.mil/stigs/srg-stig-tools/
```

**Linux Systems:**
```bash
# Ensure bash 4.0+ and root/sudo access
bash --version
```

### Initial Setup

1. **Clone the repository:**
```bash
git clone https://github.com/yourusername/disa-stig-implementation-framework.git
cd disa-stig-implementation-framework/scripts
```

2. **Configure execution policy (Windows):**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

3. **Download SCAP benchmarks:**
   - Visit https://public.cyber.mil/stigs/
   - Download benchmarks for your platforms
   - Place in `C:\SCAP\Benchmarks\`

4. **Update script paths:**
   - Review script variables for tool locations
   - Adjust paths to match your environment
   - Update output directories as needed

---

## 📖 Usage Examples

### Example 1: Enterprise-Wide SCAP Scan

```powershell
# Scan all Windows servers in authorization boundary
$servers = Get-ADComputer -Filter {OperatingSystem -like "*Server*"} | 
           Select-Object -ExpandProperty Name

.\scap-automation\execute-scap-scan.ps1 `
    -TargetSystems $servers `
    -ScanProfile "Windows_Server_2022" `
    -OutputPath "C:\SCAP\Results\MonthlyScans\2026-01"
```

### Example 2: Validate STIG GPO Deployment

```powershell
# Check if STIG GPO is applying correctly to all workstations
.\gpo-management\validate-gpo-application.ps1 `
    -GPOName "STIG_Windows11_v1r5" `
    -OutputPath "C:\Reports\GPO-Validation"
```

### Example 3: Scheduled Continuous Monitoring

```powershell
# Create scheduled task for monthly SCAP scans
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" `
    -Argument "-File C:\Scripts\scap-automation\execute-scap-scan.ps1 -TargetSystems @('ALL') -ScanProfile 'Windows_11'"

$trigger = New-ScheduledTaskTrigger -Monthly -DaysOfMonth 15 -At 2AM

Register-ScheduledTask -TaskName "Monthly_SCAP_Scan" `
    -Action $action -Trigger $trigger -RunLevel Highest
```

---

## 🔒 Security Considerations

### Credential Management

**DO NOT hardcode credentials in scripts.**

**Best Practices:**
```powershell
# Use saved credentials
$credential = Get-Credential
.\execute-scap-scan.ps1 -Credential $credential

# Or use Windows Credential Manager
# Store once: cmdkey /generic:SCANCredential /user:DOMAIN\SCANAccount /pass
# Retrieve in script using Windows API
```

### Least Privilege

- SCAP scanning requires **read-only access** to system configurations
- GPO validation requires **read access** to Active Directory
- Use dedicated service accounts with minimal permissions
- Avoid using Domain Admin accounts where possible

### Audit Logging

All scripts include detailed logging:
- Execution timestamps
- Target systems
- Success/failure status
- Error messages
- Output file locations

**Log locations:**
- SCAP scans: `$OutputPath\scan-log_YYYYMMDD_HHmmss.txt`
- GPO validation: `$OutputPath\gpo-validation_YYYYMMDD_HHmmss.txt`

---

## 📊 Output Formats

### SCAP Scan Results

Scripts generate multiple output formats:

**XML/XCCDF Results:**
```
SystemName_ScanProfile_YYYYMMDD_HHmmss.xml
```
- Standard SCAP format
- Compatible with STIG Viewer
- Contains all check results

**CSV Summary:**
```
scan-summary_YYYYMMDD_HHmmss.csv
```
- Quick compliance overview
- System-by-system results
- Import into Excel for analysis

**Text Logs:**
```
scan-log_YYYYMMDD_HHmmss.txt
```
- Detailed execution log
- Error messages and troubleshooting info
- Audit trail

### GPO Validation Results

**CSV Reports:**
```
gpo-validation-results_YYYYMMDD_HHmmss.csv
gpo-health-check_YYYYMMDD_HHmmss.csv
gpo-issues_YYYYMMDD_HHmmss.csv
```

---

## ⚙️ Customization

### Modifying Scan Profiles

Edit the `$BenchmarkMap` hashtable in `execute-scap-scan.ps1`:

```powershell
$BenchmarkMap = @{
    "Windows_11" = "C:\SCAP\Benchmarks\U_MS_Windows_11_V1R5_STIG_SCAP_1-2_Benchmark.xml"
    "Windows_Server_2022" = "C:\SCAP\Benchmarks\U_MS_Windows_Server_2022_V1R3_STIG_SCAP_1-2_Benchmark.xml"
    # Add your custom profiles here
}
```

### Adjusting Log Levels

Modify the `Write-Log` function to control verbosity:

```powershell
# Current levels: INFO, WARNING, ERROR, SUCCESS
# Add DEBUG level for troubleshooting
function Write-Log {
    param([string]$Message, [string]$Level="INFO")
    
    # Add -Verbose parameter support
    if ($Level -eq "DEBUG" -and -not $VerbosePreference) {
        return
    }
    # ... rest of function
}
```

---

## 🐛 Troubleshooting

### Common Issues

**Issue:** "SCAP Compliance Checker not found"
```
Solution: Verify SCC installation path in script
$SCCPath = "C:\Program Files\SCAP\SCC\cscc.exe"
Update to match your installation location
```

**Issue:** "Access denied" during remote scanning
```
Solution: Verify credentials have admin rights on target systems
Check Windows Firewall allows WMI and remote registry access
Ensure WinRM is enabled: Enable-PSRemoting -Force
```

**Issue:** "GPO not found in Active Directory"
```
Solution: Verify GPO name matches exactly (case-sensitive)
Check you have read permissions to Group Policy objects
Ensure you're connected to the correct domain
```

**Issue:** "Benchmark file not found"
```
Solution: Download latest benchmarks from https://public.cyber.mil/stigs/
Place in correct directory (default: C:\SCAP\Benchmarks\)
Update $BenchmarkMap with correct paths
```

### Debug Mode

Run scripts with verbose output:
```powershell
.\execute-scap-scan.ps1 -Verbose
```

Check log files for detailed error messages:
```powershell
Get-Content $OutputPath\scan-log_*.txt | Select-String "ERROR"
```

---

## 📝 Contributing

Contributions to improve these scripts are welcome!

**Guidelines:**
- Follow existing code style and structure
- Include detailed comments explaining logic
- Add error handling for all external calls
- Update this README with new features
- Test thoroughly before submitting PR

**Suggested Improvements:**
- Parallel execution for faster scanning
- Integration with ticketing systems (ServiceNow, JIRA)
- Dashboard visualization (export to Power BI, Splunk)
- Email notifications for scan completion
- Automated POA&M creation for new findings

---

## 📚 Additional Resources

**DISA STIG Resources:**
- STIG Document Library: https://public.cyber.mil/stigs/
- SCAP Tools: https://public.cyber.mil/stigs/scap/
- STIG Viewer: https://public.cyber.mil/stigs/srg-stig-tools/

**Microsoft Documentation:**
- Group Policy Overview: https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831791(v=ws.11)
- PowerShell Remoting: https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/running-remote-commands

**NIST Resources:**
- RMF Documentation: https://csrc.nist.gov/projects/risk-management
- SP 800-53 Controls: https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final

---

## 📄 License

These scripts are provided under the MIT License. See the repository LICENSE file for details.

---

## ⚠️ Disclaimer

These scripts are provided as operational tools and examples. Always:
- Test in non-production environments first
- Review and customize for your specific environment
- Follow your organization's change management procedures
- Validate results against official DISA STIGs
- Obtain proper approvals before deployment

**Use at your own risk. The authors are not responsible for any issues arising from script usage.**

---

**Last Updated:** January 2026  
**Maintained by:** ISSO Security Team  
**Questions?** Open an issue in the GitHub repository
