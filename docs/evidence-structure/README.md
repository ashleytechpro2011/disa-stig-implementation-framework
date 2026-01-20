# STIG Compliance Evidence Organization

This directory provides a standardized framework for organizing STIG compliance evidence to support RMF assessments and continuous monitoring activities.

---

## 🎯 Purpose

Proper evidence organization is critical for:

**Assessment Success:**
- Assessors can quickly locate required artifacts
- Evidence clearly supports compliance claims
- Complete documentation package demonstrates thoroughness
- Professional presentation builds assessor confidence

**Continuous Monitoring:**
- Historical evidence preserved for trend analysis
- Easy comparison between assessment periods
- Quick retrieval for ad-hoc reviews
- Audit trail for compliance decisions

**Knowledge Management:**
- New ISSOstep into organized documentation
- Departing ISSOleave behind clear records
- Stakeholders can self-serve basic questions
- Institutional knowledge preserved

---

## 📁 Recommended Folder Structure

```
STIG_Evidence_[SYSTEM_NAME]/
│
├── 00_Master_Documentation/
│   ├── System_Security_Plan.pdf
│   ├── Security_Assessment_Report.pdf
│   ├── Authorization_To_Operate.pdf
│   ├── STIG_Applicability_Matrix.xlsx
│   └── Evidence_Index.xlsx
│
├── 01_SCAP_Scan_Results/
│   ├── 2026-01-January/
│   │   ├── windows-systems/
│   │   │   ├── SERVER01_Windows_Server_2022_20260115.xml
│   │   │   ├── SERVER02_Windows_Server_2022_20260115.xml
│   │   │   └── scan-summary-windows-20260115.csv
│   │   ├── linux-systems/
│   │   │   ├── RHEL01_RHEL_8_20260115.xml
│   │   │   └── scan-summary-linux-20260115.csv
│   │   └── monthly-scan-report-2026-01.pdf
│   ├── 2025-12-December/
│   └── 2025-11-November/
│
├── 02_STIG_Checklists/
│   ├── Current_Assessment/
│   │   ├── Windows_11/
│   │   │   ├── WKS001_Windows11_v1r5_20260115.ckl
│   │   │   └── WKS002_Windows11_v1r5_20260115.ckl
│   │   ├── Windows_Server_2022/
│   │   │   └── SERVER01_WinServer2022_v1r3_20260115.ckl
│   │   ├── RHEL_8/
│   │   │   └── RHEL01_RHEL8_v1r9_20260115.ckl
│   │   └── Network_Devices/
│   │       └── RTR01_Cisco_IOS_Manual_20260115.ckl
│   └── Previous_Assessments/
│       ├── 2025_Annual_Assessment/
│       └── 2024_Annual_Assessment/
│
├── 03_GPO_Configurations/
│   ├── Active_GPOs/
│   │   ├── STIG_Windows11_v1r5/
│   │   │   ├── GPO_Backup/
│   │   │   ├── GPO_Report.html
│   │   │   ├── Settings_Documentation.md
│   │   │   └── Deployment_Evidence.pdf
│   │   └── STIG_Windows_Server_2022_v1r3/
│   ├── Test_GPOs/
│   └── Deprecated_GPOs/
│
├── 04_Manual_Validation_Evidence/
│   ├── Configuration_Files/
│   │   ├── sshd_config_RHEL01_20260115.txt
│   │   ├── audit.rules_RHEL01_20260115.txt
│   │   └── firewall_config_RTR01_20260115.txt
│   ├── Command_Outputs/
│   │   ├── getenforce_output_RHEL01_20260115.txt
│   │   ├── systemctl_status_auditd_20260115.txt
│   │   └── show_running-config_RTR01_20260115.txt
│   └── Screenshots/
│       ├── UAC_Settings_WKS001_20260115.png
│       └── Firewall_Rules_WKS001_20260115.png
│
├── 05_Compensating_Controls/
│   ├── Active_Compensating_Controls/
│   │   ├── CC-001_UAC_Legacy_App/
│   │   │   ├── Compensating_Control_Documentation.pdf
│   │   │   ├── Risk_Assessment.pdf
│   │   │   ├── ISSM_Approval.pdf
│   │   │   ├── Network_Segmentation_Evidence.pdf
│   │   │   ├── SIEM_Monitoring_Evidence.pdf
│   │   │   └── Monthly_Effectiveness_Reviews/
│   │   └── CC-002_FIPS_Hardware_Limitation/
│   └── Closed_Compensating_Controls/
│
├── 06_POAMs/
│   ├── Active_POAMs/
│   │   ├── POAM-2026-001_SELinux_Policy/
│   │   │   ├── POA&M_Entry.pdf
│   │   │   ├── Milestone_Evidence/
│   │   │   └── Monthly_Updates/
│   │   └── POAM-2026-002_FIPS_Implementation/
│   ├── Closed_POAMs/
│   │   └── POAM-2025-012_UAC_Migration/
│   │       ├── POA&M_Entry.pdf
│   │       ├── Closure_Evidence.pdf
│   │       └── Lessons_Learned.md
│   └── POA&M_Status_Reports/
│       ├── 2026-01_POAM_Status.pdf
│       └── 2025-12_POAM_Status.pdf
│
├── 07_Vulnerability_Scans/
│   ├── ACAS_Nessus_Scans/
│   │   ├── 2026-01/
│   │   │   ├── Weekly_Scans/
│   │   │   └── Monthly_Summary.pdf
│   │   └── 2025-12/
│   └── Authenticated_Scans/
│
├── 08_Remediation_Evidence/
│   ├── Patch_Deployment/
│   │   ├── 2026-01_Patch_Tuesday/
│   │   │   ├── Patch_List.xlsx
│   │   │   ├── Pre_Scan_Results.pdf
│   │   │   ├── Post_Scan_Results.pdf
│   │   │   └── Deployment_Report.pdf
│   │   └── 2025-12_Patch_Tuesday/
│   ├── Configuration_Changes/
│   │   ├── Change_Request_001_UAC_Settings/
│   │   │   ├── Change_Request.pdf
│   │   │   ├── Testing_Results.pdf
│   │   │   ├── Approval.pdf
│   │   │   ├── Implementation_Evidence.pdf
│   │   │   └── Verification_Scan.xml
│   │   └── Change_Request_002_SSH_Hardening/
│   └── GPO_Updates/
│
├── 09_Monthly_Reports/
│   ├── 2026/
│   │   ├── 2026-01_Status_Report.pdf
│   │   ├── 2026-01_Metrics_Dashboard.xlsx
│   │   └── 2026-01_Executive_Summary.pdf
│   └── 2025/
│
├── 10_Assessment_Packages/
│   ├── 2026_Annual_Assessment/
│   │   ├── Evidence_Index.xlsx
│   │   ├── Self_Assessment_Results.pdf
│   │   ├── Assessor_Provided_Documents/
│   │   ├── Evidence_Submitted_to_Assessor/
│   │   └── Final_SAR.pdf
│   └── 2025_Annual_Assessment/
│
└── 11_Supporting_Documentation/
    ├── Training_Records/
    ├── Meeting_Notes/
    ├── Vendor_Correspondence/
    ├── Technical_Justifications/
    └── Lessons_Learned/
```

---

## 📋 Folder Descriptions

### **00_Master_Documentation**

**Purpose:** Central repository for system-level documents

**Contents:**
- System Security Plan (SSP)
- Security Assessment Report (SAR)
- Authorization to Operate (ATO) letter
- STIG applicability matrix
- Master evidence index

**Update Frequency:** As system changes or annually

**Access Control:** Restricted to ISSO, ISSM, and authorized personnel

---

### **01_SCAP_Scan_Results**

**Purpose:** Automated STIG compliance validation evidence

**Organization:** By month, then by platform

**Retention:** 24 months minimum (2 years of continuous monitoring data)

**File Naming:**
```
[HOSTNAME]_[PLATFORM]_[STIG_VERSION]_[YYYYMMDD].xml
Example: SERVER01_Windows_Server_2022_20260115.xml
```

**Why This Matters:**
- Trend analysis requires historical data
- Assessors may request prior period results
- Configuration drift detection needs baselines

---

### **02_STIG_Checklists**

**Purpose:** Official STIG compliance documentation in DISA format

**Organization:** Current assessment separate from historical

**File Naming:**
```
[HOSTNAME]_[PLATFORM][VERSION]_[YYYYMMDD].ckl
Example: RHEL01_RHEL8_v1r9_20260115.ckl
```

**Critical Files:**
- Individual system checklists (.ckl or .json format)
- Consolidated checklists (if used)
- Assessment-specific checklist packages

**Backup:** Always maintain local AND eMASS copies

---

### **03_GPO_Configurations**

**Purpose:** Document Group Policy-based STIG implementation

**Organization:** By GPO, with backups and documentation

**Contents Per GPO:**
- GPO backup (restorable)
- HTML or XML report
- Settings documentation (markdown)
- Deployment evidence
- Testing results
- Change history

**Retention:** Keep deprecated GPOs for 1 year after retirement

---

### **04_Manual_Validation_Evidence**

**Purpose:** Evidence for findings SCAP cannot automatically validate

**Sub-folders:**
- **Configuration Files:** System config files as evidence
- **Command Outputs:** CLI output proving configuration
- **Screenshots:** GUI evidence when no CLI alternative exists

**Best Practices:**
- Include timestamps in filenames
- Embed system identification in outputs
- Maintain chain of custody documentation

---

### **05_Compensating_Controls**

**Purpose:** Document risk-based deviations with approved mitigations

**Organization:** One folder per compensating control

**Contents Per Control:**
- Compensating control documentation
- Risk assessment
- ISSM approval memo
- Evidence of control implementation
- Monthly effectiveness reviews
- Continuous monitoring data

**Retention:** Keep 3 years after control removed

---

### **06_POAMs**

**Purpose:** Track findings requiring extended remediation

**Organization:** Active vs. Closed, then by POA&M ID

**Contents Per POA&M:**
- POA&M entry document
- Milestone evidence as completed
- Monthly status updates
- Change documentation (if timeline adjusted)
- Closure evidence and verification

**Critical:** Update monthly, even if "no change"

---

### **07_Vulnerability_Scans**

**Purpose:** Correlation between STIG findings and exploitable vulnerabilities

**Organization:** By month and scan type

**Contents:**
- Weekly/monthly ACAS scans
- Critical vulnerability reports
- Authenticated vs. unauthenticated scans
- Remediation tracking

**Integration:** Cross-reference with SCAP findings for prioritization

---

### **08_Remediation_Evidence**

**Purpose:** Document how findings were resolved

**Organization:** By remediation type and change request

**Contents:**
- Change request documentation
- Testing results (before/after)
- Approval documentation
- Implementation evidence
- Verification scans or validation

**Why This Matters:**
- Proves findings were actually fixed, not just marked closed
- Supports assessment validation
- Demonstrates change control compliance

---

### **09_Monthly_Reports**

**Purpose:** Executive reporting and continuous monitoring documentation

**Organization:** By year and month

**Contents:**
- Monthly status reports
- Metrics dashboards
- Executive summaries
- Trend analysis
- Action item tracking

**Audience:** ISSM, System Owner, Program Leadership

---

### **10_Assessment_Packages**

**Purpose:** Organize evidence for security assessments

**Organization:** By assessment cycle

**Contents:**
- Evidence index (what's where)
- Self-assessment results
- Assessor questions and responses
- Evidence submitted to assessor
- Final Security Assessment Report
- Assessment findings and responses

**Timeline:** Begin organizing 60 days before assessment

---

### **11_Supporting_Documentation**

**Purpose:** Everything else that supports the compliance program

**Contents:**
- Training certificates
- Meeting minutes and decisions
- Vendor correspondence
- Technical white papers and justifications
- Lessons learned
- Process documentation

---

## 📊 Evidence Index

### Master Evidence Index Template

Create a master Excel spreadsheet: `00_Master_Documentation/Evidence_Index.xlsx`

**Columns:**
1. Evidence ID (unique identifier)
2. Evidence Type (SCAP scan, checklist, GPO, etc.)
3. Description
4. Location (folder path)
5. Filename
6. Date Created
7. Date Last Updated
8. Related STIG IDs
9. Related NIST 800-53 Controls
10. Related POA&Ms
11. Retention Date
12. Notes

**Example Row:**
```
ID: EVID-2026-001
Type: SCAP Scan
Description: Monthly Windows Server SCAP scan results
Location: 01_SCAP_Scan_Results/2026-01-January/windows-systems/
Filename: SERVER01_Windows_Server_2022_20260115.xml
Created: 01/15/2026
Updated: 01/15/2026
STIG IDs: All Windows Server 2022 STIG V1R3
Controls: All AC, AU, CM, IA, SC controls
POA&Ms: None
Retention: 01/15/2028
Notes: Baseline scan for continuous monitoring
```

---

## 🔐 Access Control and Security

### Classification Markings

**Apply appropriate markings to all evidence:**

```
Evidence Type                     Typical Classification
─────────────────────────────────────────────────────────
SCAP scan results                 CUI
STIG checklists                   CUI
Configuration files               CUI (may contain sensitive settings)
Network diagrams                  CUI
POA&M documents                   CUI
Monthly reports                   CUI
Assessment reports                CUI (or higher if system is classified)
```

### Folder Permissions

**Recommended access levels:**

```
Folder                            Read        Write       Delete
──────────────────────────────────────────────────────────────────
00_Master_Documentation           ISSO/ISSM   ISSO        ISSO+ISSM
01_SCAP_Scan_Results             All Team    ISSO        ISSO
02_STIG_Checklists               All Team    ISSO        ISSO
03_GPO_Configurations            All Team    AD Admin    ISSO
04_Manual_Validation_Evidence    All Team    All Team    ISSO
05_Compensating_Controls         ISSO/ISSM   ISSO        ISSO
06_POAMs                         ISSO/ISSM   ISSO        ISSO
07_Vulnerability_Scans           All Team    Vuln Team   ISSO
08_Remediation_Evidence          All Team    All Team    ISSO
09_Monthly_Reports               All Team    ISSO        ISSO
10_Assessment_Packages           ISSO/ISSM   ISSO        ISSO+ISSM
11_Supporting_Documentation      All Team    All Team    ISSO
```

---

## 📅 Retention Schedule

### Minimum Retention Periods

```
Document Type                     Retention Period        Rationale
────────────────────────────────────────────────────────────────────
SCAP scan results                 24 months              Continuous monitoring trend analysis
STIG checklists (current)         Until next assessment  Active compliance evidence
STIG checklists (historical)      3 years                Assessment comparison, audit trail
POA&Ms (active)                   Until closure          Active risk management
POA&Ms (closed)                   3 years                Lessons learned, audit trail
Compensating controls (active)    Until removed          Active risk acceptance
Compensating controls (closed)    3 years                Compliance history
Monthly reports                   3 years                Program metrics, trend analysis
Assessment packages               Permanent              Regulatory requirement
GPO backups (active)              Until deprecated       Disaster recovery
GPO backups (deprecated)          1 year                 Rollback capability
Remediation evidence              3 years                Audit trail
```

### Archival Process

**Annual Archive Routine:**

1. **January:** Archive previous year's monthly reports
2. **After Assessment:** Archive complete assessment package
3. **Quarterly:** Review and archive closed POA&Ms >1 year old
4. **Annually:** Purge evidence past retention date

---

## 🔄 Maintenance Procedures

### Daily Tasks

- [ ] Save new evidence to appropriate folders
- [ ] Update evidence index for significant new items
- [ ] Verify backup jobs completed successfully

### Weekly Tasks

- [ ] Review evidence organization for consistency
- [ ] Move completed work from working folders to final locations
- [ ] Check folder sizes and storage capacity

### Monthly Tasks

- [ ] Archive previous month's continuous monitoring evidence
- [ ] Update retention dates in evidence index
- [ ] Generate and file monthly status report
- [ ] Review access permissions for currency

### Quarterly Tasks

- [ ] Review folder structure for needed adjustments
- [ ] Purge evidence past retention dates
- [ ] Validate backup restoration procedures
- [ ] Update this documentation if structure changed

### Annually Tasks

- [ ] Complete full evidence inventory
- [ ] Archive assessment packages
- [ ] Review and update retention schedule
- [ ] Validate compliance with records management requirements

---

## 🔍 Quality Checks

### Evidence Quality Checklist

Before filing evidence, verify:

- [ ] **Filename** follows naming convention
- [ ] **Date** embedded in filename or metadata
- [ ] **System identification** clear in content
- [ ] **Evidence** actually proves the claim
- [ ] **Classification** markings applied
- [ ] **Index** updated with new evidence
- [ ] **Location** correct per folder structure
- [ ] **Format** acceptable (not proprietary if avoidable)
- [ ] **Completeness** - no truncated files

### Periodic Spot Checks

Monthly, randomly select 5 evidence items and verify:
- File is not corrupted
- Content matches index description
- Still within retention period
- Classification appropriate
- Actually supports compliance claim

---

## 🚀 Getting Started

### New System Setup

1. **Create folder structure:**
```bash
mkdir -p STIG_Evidence_SystemName/{00..11}_FolderName
# Fill in actual folder names from structure above
```

2. **Create evidence index:**
   - Copy template from this directory
   - Customize for your system
   - Store in 00_Master_Documentation

3. **Set permissions:**
   - Apply access controls per table above
   - Document permissions in README

4. **Initial population:**
   - Move existing evidence to appropriate folders
   - Update index
   - Purge duplicate or outdated evidence

### Migration from Existing Structure

1. **Map current to new:**
   - List all current evidence locations
   - Identify corresponding new folders
   - Create migration plan

2. **Execute migration:**
   - Copy (don't move initially) to preserve originals
   - Validate all evidence accessible
   - Update index
   - Verify no gaps

3. **Cutover:**
   - Update documentation to reference new structure
   - Train team on new locations
   - Archive old structure after 30-day validation period

---

## 📚 Additional Resources

**DoD Records Management:**
- DoD 5015.2-STD: Electronic Records Management Software Applications Design Criteria
- DoD Instruction 5015.02: DoD Records Management Program

**eMASS Guidance:**
- eMASS User Guide (access through DISA)
- eMASS Evidence Artifact Requirements

**NIST Guidance:**
- SP 800-53A Rev 5: Assessing Security and Privacy Controls
- SP 800-137: Information Security Continuous Monitoring

---

## 🤝 Support

**Questions about evidence organization?**
- Consult your ISSM for organization-specific requirements
- Review DoD Component records management guidance
- Reference RMF Knowledge Service

**Need help with evidence index?**
- Template available in this directory
- Examples in the /examples folder
- Contact repository maintainers

---

**Last Updated:** January 2026  
**Maintained by:** ISSO Security Team  
**Next Review:** January 2027
