# DISA STIG Implementation - Complete Execution Checklist

## **Pre-Implementation Phase**

### **Step 1: Review RMF Authorization Boundary**
- [ ] Obtain and review the approved System Security Plan (SSP)
- [ ] Identify system categorization (CIA impact levels: Low/Moderate/High)
- [ ] Document all systems within the authorization boundary
- [ ] Review control inheritance mappings
- [ ] Identify which components require STIG implementation
- [ ] Confirm current ATO status and expiration date

### **Step 2: Determine Applicable STIGs**
- [ ] Based on system categorization, identify required STIG baselines
- [ ] Download current STIG versions from https://public.cyber.mil/stigs/
- [ ] Document STIG version numbers and release dates
- [ ] Identify operating systems in scope (Windows, Linux, UNIX, etc.)
- [ ] Identify application STIGs required (SQL, Oracle, web servers, etc.)
- [ ] Identify network device STIGs (routers, switches, firewalls, etc.)
- [ ] Create STIG applicability matrix for the authorization boundary

### **Step 3: Stakeholder Coordination**
- [ ] Schedule kickoff meeting with ISSM
- [ ] Notify System Owner of implementation timeline
- [ ] Coordinate with system administrators for access
- [ ] Coordinate with network administrators for access
- [ ] Brief program leadership on scope and schedule
- [ ] Establish communication plan for status updates
- [ ] Identify points of contact for each system type

---

## **Phase 1: Baseline Configuration via Active Directory/Group Policy**

### **Step 4: Prepare Active Directory Environment**
- [ ] Verify Domain Controller access and permissions
- [ ] Document current Organizational Unit (OU) structure
- [ ] Identify target OUs for STIG GPO application
- [ ] Create test OU for GPO validation before production deployment
- [ ] Backup existing Group Policy Objects
- [ ] Document current baseline configurations

### **Step 5: Create or Import STIG GPOs**
- [ ] Download STIG GPO packages from DISA (if available)
- [ ] Import STIG GPOs into Group Policy Management Console (GPMC)
- [ ] Review each GPO setting for applicability to your environment
- [ ] Customize GPOs for mission-specific requirements (document all changes)
- [ ] Create separate GPOs for different STIG categories:
  - [ ] Computer configuration settings
  - [ ] User configuration settings
  - [ ] Security settings (password policy, account lockout, audit policy)
  - [ ] Administrative templates
  - [ ] Registry settings

### **Step 6: Test GPO Deployment**
- [ ] Link STIG GPOs to test OU
- [ ] Apply GPOs to test systems (minimum 3-5 representative systems)
- [ ] Force Group Policy update: `gpupdate /force`
- [ ] Verify no operational impact on test systems
- [ ] Test mission-critical applications for functionality
- [ ] Review Event Viewer for GPO application errors
- [ ] Document any conflicts or issues discovered
- [ ] Adjust GPO settings as needed based on test results

### **Step 7: Deploy GPOs to Production**
- [ ] Schedule deployment during approved maintenance window
- [ ] Link STIG GPOs to production OUs in proper precedence order
- [ ] Deploy in phases (e.g., 10% of systems, then 50%, then 100%)
- [ ] Monitor for issues during phased rollout
- [ ] Force Group Policy update on target systems
- [ ] Verify GPO application via `gpresult /h report.html` on sample systems
- [ ] Document deployment completion date and time
- [ ] Allow 24-48 hours for full propagation across enterprise

---

## **Phase 2: Automated Compliance Validation via SCAP**

### **Step 8: Prepare SCAP Scanning Environment**
- [ ] Download latest SCAP Compliance Checker (SCC) from DISA
- [ ] Download current SCAP benchmarks for applicable STIGs
- [ ] Verify SCAP content version matches STIG version
- [ ] Install SCC on scanning workstation or server
- [ ] Configure network access to target systems
- [ ] Obtain necessary credentials for authenticated scanning
- [ ] Create scanning schedule (avoid peak operational hours)

### **Step 9: Execute SCAP Scans**
- [ ] Launch SCAP Compliance Checker (SCC)
- [ ] Select appropriate SCAP benchmark for each system type
- [ ] Configure scan settings:
  - [ ] Enable authenticated scanning
  - [ ] Select target systems or IP ranges
  - [ ] Configure output format (XCCDF/XML)
  - [ ] Set output directory for results
- [ ] Execute scans against all systems in authorization boundary
- [ ] Monitor scan progress and troubleshoot connection issues
- [ ] Verify scan completion for all target systems
- [ ] Save scan results with clear naming convention: `SystemName_STIG_YYYYMMDD.xml`

### **Step 10: Initial Results Review**
- [ ] Review scan completion status for each system
- [ ] Identify systems with scan failures or errors
- [ ] Re-scan any failed systems after troubleshooting
- [ ] Verify output files are valid and readable
- [ ] Create backup copies of all scan results
- [ ] Document scan execution date, tool version, and benchmark version

---

## **Phase 3: Manual Validation via STIG Viewer**

### **Step 11: Prepare STIG Viewer**
- [ ] Download latest STIG Viewer from DISA
- [ ] Install STIG Viewer on workstation
- [ ] Download current STIG checklists (.xml files) from cyber.mil
- [ ] Organize checklists by system type in dedicated folders

### **Step 12: Import SCAP Results into STIG Viewer**
- [ ] Launch STIG Viewer
- [ ] Create new checklist or import STIG .xml file
- [ ] Import SCAP scan results (.xml or XCCDF file)
- [ ] Review import summary for errors or warnings
- [ ] Verify checklist populated correctly with scan results
- [ ] Save checklist as .ckl or .json file with clear naming: `SystemName_STIG_Checklist_YYYYMMDD.ckl`

### **Step 13: Analyze Automated Scan Results**
For each system checklist:
- [ ] Review findings categorized as **"Open" (Failed)**
- [ ] Review findings categorized as **"Not a Finding" (Passed)**
- [ ] Review findings categorized as **"Not Reviewed" (Requires Manual Check)**
- [ ] Review findings categorized as **"Not Applicable"**
- [ ] Document total count for each category
- [ ] Prioritize "Open" findings by CAT I (High), CAT II (Medium), CAT III (Low)

### **Step 14: Perform Manual Validation**
For each **"Not Reviewed"** finding:
- [ ] Read the STIG requirement in detail
- [ ] Determine validation method (config file review, command execution, GUI check)
- [ ] Access the target system with appropriate credentials
- [ ] Execute validation steps documented in the STIG check content
- [ ] Document findings and evidence (screenshots, command output, config snippets)
- [ ] Update STIG Viewer status:
  - [ ] Mark as "Not a Finding" if compliant (document evidence in Comments)
  - [ ] Mark as "Open" if non-compliant (document finding details in Comments)
  - [ ] Mark as "Not Applicable" if check doesn't apply (document justification)

### **Step 15: Document All Findings**
In STIG Viewer, for each finding:
- [ ] Enter detailed comments explaining the status determination
- [ ] Include specific evidence (file paths, registry keys, command output)
- [ ] Note who performed the validation and when
- [ ] For "Open" findings, include initial impact assessment
- [ ] For "Not Applicable" findings, include clear technical justification
- [ ] Save updated checklist after each system review

---

## **Phase 4: Remediation and GPO Adjustment**

### **Step 16: Analyze Remediation Requirements**
- [ ] Compile all "Open" findings across all systems
- [ ] Group findings by remediation type:
  - [ ] GPO adjustments (can be fixed via Group Policy)
  - [ ] Manual configuration changes (require system-level changes)
  - [ ] Patch/update requirements (require software updates)
  - [ ] Hardware/architectural limitations (may require compensating controls)
- [ ] Prioritize remediation: CAT I first, then CAT II, then CAT III
- [ ] Estimate remediation effort and timeline for each finding

### **Step 17: Remediate via Group Policy**
For findings that can be resolved via GPO:
- [ ] Identify the specific GPO setting needed
- [ ] Modify existing STIG GPO or create new remediation GPO
- [ ] Test GPO change in test OU first
- [ ] Verify no negative impact on test systems
- [ ] Deploy GPO change to production OUs
- [ ] Force Group Policy update: `gpupdate /force`
- [ ] Allow 24-48 hours for propagation
- [ ] Document GPO changes in change management system

### **Step 18: Remediate via Manual Configuration**
For findings requiring system-level changes:
- [ ] Create remediation scripts where possible (PowerShell, Bash, etc.)
- [ ] Test scripts in non-production environment
- [ ] Schedule changes during approved maintenance window
- [ ] Execute configuration changes on target systems
- [ ] Document changes in system configuration logs
- [ ] Verify changes applied successfully
- [ ] Update system documentation to reflect new baseline

### **Step 19: Re-Scan After Remediation**
- [ ] Wait minimum 48 hours after GPO deployment
- [ ] Execute new SCAP scans on all remediated systems
- [ ] Import new scan results into STIG Viewer
- [ ] Compare new results to previous scan results
- [ ] Verify "Open" findings now show as "Not a Finding"
- [ ] Document remediation verification date
- [ ] If findings still open, investigate root cause and re-remediate

---

## **Phase 5: Deviation Management and Compensating Controls**

### **Step 20: Identify Findings Requiring Deviations**
- [ ] Review all remaining "Open" findings after remediation attempts
- [ ] Categorize findings by reason for non-compliance:
  - [ ] Mission-critical application incompatibility
  - [ ] Legacy system limitations
  - [ ] Vendor-specific constraints
  - [ ] Operational requirement conflicts
  - [ ] Technical impossibility on current architecture
- [ ] Schedule risk assessment meeting with ISSM and System Owner

### **Step 21: Document Compensating Controls**
For each deviation:
- [ ] Document the specific STIG requirement
- [ ] Explain why full compliance cannot be achieved
- [ ] Perform risk assessment (likelihood and impact)
- [ ] Identify alternative security controls that mitigate the risk
- [ ] Document compensating controls in detail:
  - [ ] What control is being implemented
  - [ ] How it reduces risk to acceptable level
  - [ ] How it aligns with original RMF control intent
  - [ ] Who is responsible for maintaining the compensating control
- [ ] Obtain ISSM approval for compensating control approach

### **Step 22: Create POA&M Entries**
For findings requiring extended remediation:
- [ ] Access eMASS or equivalent system of record
- [ ] Create POA&M entry for each finding or group of related findings
- [ ] Include the following in each POA&M:
  - [ ] STIG ID and title
  - [ ] Current status and risk level
  - [ ] Root cause analysis
  - [ ] Planned remediation approach
  - [ ] Milestones with realistic dates
  - [ ] Resources required
  - [ ] Interim compensating controls
  - [ ] Points of contact responsible
- [ ] Link POA&M entries to affected systems in eMASS
- [ ] Set up recurring reviews for POA&M progress tracking

---

## **Phase 6: Documentation and Evidence Package**

### **Step 23: Prepare eMASS Documentation**
- [ ] Log into eMASS system of record
- [ ] Navigate to the system's package
- [ ] Upload STIG checklists (.ckl or .json files) for each system
- [ ] Upload SCAP scan results (.xml files) as supporting artifacts
- [ ] Update SSP control descriptions to reflect STIG implementation
- [ ] Document GPO configurations as control implementation evidence
- [ ] Upload compensating control documentation
- [ ] Ensure all POA&Ms are properly linked to controls and systems

### **Step 24: Update System Security Plan**
- [ ] Review current SSP control statements
- [ ] Update control implementation descriptions to include STIG compliance
- [ ] Add references to specific STIG IDs where applicable
- [ ] Document GPO names and settings used for enforcement
- [ ] Include compensating control descriptions in relevant controls
- [ ] Update control implementation status (Implemented, Partially Implemented, etc.)
- [ ] Add STIG compliance as evidence in control description fields
- [ ] Obtain ISSM review and approval of SSP updates

### **Step 25: Organize Evidence Package**
Create a complete evidence folder structure:
```
STIG_Implementation_Evidence/
├── SCAP_Scan_Results/
│   ├── Initial_Scans/
│   └── Post_Remediation_Scans/
├── STIG_Checklists/
│   ├── Windows_Systems/
│   ├── Linux_Systems/
│   └── Network_Devices/
├── GPO_Documentation/
│   ├── GPO_Exports/
│   ├── GPO_Reports/
│   └── GPO_Settings_Screenshots/
├── Compensating_Controls/
├── POAMs/
├── SSP_Updates/
└── Remediation_Scripts/
```

- [ ] Populate each folder with relevant artifacts
- [ ] Ensure consistent file naming conventions
- [ ] Include README files explaining folder contents
- [ ] Create an evidence index spreadsheet listing all artifacts
- [ ] Store in approved secure repository
- [ ] Ensure backup copies exist

---

## **Phase 7: Validation and Assessment**

### **Step 26: Internal Validation**
- [ ] Conduct peer review of STIG checklists
- [ ] Verify all findings have appropriate status and comments
- [ ] Confirm evidence supports all "Not a Finding" determinations
- [ ] Review compensating controls for adequacy
- [ ] Validate POA&M milestones are realistic and on track
- [ ] Conduct configuration spot-checks on sample systems
- [ ] Review GPO application reports from sample systems

### **Step 27: ISSM Review**
- [ ] Schedule formal review meeting with ISSM
- [ ] Present STIG implementation summary:
  - [ ] Total findings by category (Open, Closed, N/A)
  - [ ] Compliance percentage
  - [ ] Deviations and compensating controls
  - [ ] POA&M status
- [ ] Walk through sample findings and evidence
- [ ] Address ISSM questions and concerns
- [ ] Obtain ISSM sign-off on approach and documentation
- [ ] Document ISSM feedback and implement any requested changes

### **Step 28: Security Assessor Validation**
- [ ] Provide evidence package to independent security assessors
- [ ] Brief assessors on implementation approach
- [ ] Provide system access for validation spot-checks
- [ ] Support assessor validation activities
- [ ] Address assessor findings and questions
- [ ] Remediate any discrepancies identified by assessors
- [ ] Obtain assessor sign-off in Security Assessment Report (SAR)

---

## **Phase 8: Continuous Monitoring**

### **Step 29: Establish Monitoring Schedule**
- [ ] Define SCAP scan frequency (typically monthly or quarterly)
- [ ] Create scanning calendar with specific dates
- [ ] Assign responsibility for scan execution
- [ ] Define escalation process for new findings
- [ ] Document monitoring procedures in SSP
- [ ] Configure automated scan scheduling if possible

### **Step 30: Execute Recurring Scans**
For each monitoring period:
- [ ] Execute SCAP scans on all systems
- [ ] Import results into STIG Viewer
- [ ] Compare results to previous baseline
- [ ] Identify new "Open" findings (configuration drift)
- [ ] Identify newly "Not Reviewed" findings (new STIG requirements)
- [ ] Investigate root cause of any drift
- [ ] Remediate new findings following Phase 4 process
- [ ] Update checklists and upload to eMASS

### **Step 31: Monitor GPO Effectiveness**
- [ ] Review Group Policy event logs for application failures
- [ ] Verify GPO reapplication is occurring every 90 minutes
- [ ] Monitor for unauthorized GPO modifications
- [ ] Review `gpresult` reports from sample systems
- [ ] Investigate and resolve any GPO conflicts
- [ ] Document GPO health status in monthly reports

### **Step 32: Configuration Drift Prevention**
- [ ] Implement change control process for all system modifications
- [ ] Require security review before configuration changes
- [ ] Use GPO to prevent unauthorized changes where possible
- [ ] Monitor for manual overrides of GPO settings
- [ ] Re-apply baseline configurations if drift detected
- [ ] Document all authorized deviations from baseline

### **Step 33: STIG Update Management**
- [ ] Monitor DISA website for new STIG releases
- [ ] Review new STIG requirements for applicability
- [ ] Assess impact of new requirements on current systems
- [ ] Update SCAP benchmarks to latest versions
- [ ] Re-scan systems with updated benchmarks
- [ ] Remediate new findings or document deviations
- [ ] Update checklists and eMASS documentation
- [ ] Notify ISSM and System Owner of STIG version changes

---

## **Phase 9: Reporting and Communication**

### **Step 34: Create Monthly Status Reports**
- [ ] Compile STIG compliance metrics:
  - [ ] Overall compliance percentage
  - [ ] Findings by category (CAT I/II/III)
  - [ ] Findings by status (Open, Closed, N/A)
  - [ ] Trend analysis vs. previous months
- [ ] Summarize remediation activities completed
- [ ] Report POA&M progress and status
- [ ] Highlight any new risks or concerns
- [ ] Distribute to ISSM, System Owner, and leadership

### **Step 35: Prepare for Assessment Activities**
- [ ] Maintain assessment readiness at all times
- [ ] Keep evidence package current and accessible
- [ ] Conduct quarterly self-assessments
- [ ] Address any gaps identified in self-assessment
- [ ] Brief new team members on STIG compliance status
- [ ] Practice explaining implementation approach for audits

---

## **Quality Checkpoints**

### **Before Moving to Next Phase:**

**After Pre-Implementation:**
- [ ] All stakeholders identified and engaged
- [ ] Authorization boundary clearly defined
- [ ] Applicable STIGs identified and downloaded

**After GPO Deployment:**
- [ ] All GPOs tested successfully
- [ ] No mission impact from GPO application
- [ ] GPO application verified via gpresult

**After SCAP Scanning:**
- [ ] All systems scanned successfully
- [ ] Scan results validated and backed up
- [ ] Results imported into STIG Viewer

**After Manual Validation:**
- [ ] All "Not Reviewed" findings addressed
- [ ] Evidence documented for all determinations
- [ ] Checklists saved and organized

**After Remediation:**
- [ ] Re-scan completed and results improved
- [ ] All remediable findings addressed
- [ ] Remaining findings have approved deviations

**After Documentation:**
- [ ] eMASS fully updated
- [ ] SSP reflects current implementation
- [ ] Evidence package complete and organized

**Before ATO/Continuous Monitoring:**
- [ ] ISSM sign-off obtained
- [ ] Assessor validation complete
- [ ] Monitoring processes established

---

## **Critical Success Factors**

✅ **Document Everything** - Every decision, finding, and remediation action  
✅ **Test Before Production** - Always validate GPO changes in test environment  
✅ **Coordinate Continuously** - Keep ISSM and stakeholders informed  
✅ **Think Risk-Based** - Not all findings require immediate full compliance  
✅ **Automate Where Possible** - Use GPO to enforce, not just validate  
✅ **Plan for Drift** - Continuous monitoring is not optional  
✅ **Maintain Evidence** - Assessors will ask—be ready with proof

---

## **Common Pitfalls to Avoid**

❌ Deploying GPOs without testing  
❌ Treating SCAP results as 100% accurate without validation  
❌ Marking findings "Not Applicable" without clear justification  
❌ Remediating findings one-by-one instead of using GPO  
❌ Ignoring "Not Reviewed" findings  
❌ Missing documentation in eMASS  
❌ Failing to monitor for configuration drift  
❌ Not updating for new STIG releases
