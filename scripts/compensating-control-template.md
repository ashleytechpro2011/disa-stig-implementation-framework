# Compensating Control Documentation Template

## Control Information

**System Name:** [Enter system name]  
**System Categorization:** [Confidentiality: High/Moderate/Low] [Integrity: High/Moderate/Low] [Availability: High/Moderate/Low]  
**Authorization Boundary:** [Enter authorization boundary identifier]  
**Document Date:** [MM/DD/YYYY]  
**Prepared By:** [ISSO Name], Information System Security Officer

---

## STIG Requirement Unable to Implement

### STIG Details
- **STIG ID:** [e.g., V-220706]
- **STIG Title:** [e.g., Windows 11 Security Technical Implementation Guide]
- **STIG Version:** [e.g., Version 1, Release 5]
- **Vulnerability ID:** [e.g., V-220706]
- **Rule ID:** [e.g., SV-220706r569187_rule]
- **Severity:** [CAT I / CAT II / CAT III]

### STIG Requirement Text
```
[Paste exact STIG requirement here]

Example:
"Windows 11 must be configured to enable User Account Control (UAC) to 
virtualize file and registry write failures to per-user locations."
```

### Control Mapping
- **NIST 800-53 Control:** [e.g., AC-6(9) - Log Execution of Privileged Functions]
- **Control Family:** [e.g., Access Control]
- **Control Description:** [Brief description of what the control is designed to protect]

---

## Technical Justification for Non-Compliance

### Reason for Inability to Implement

**Select Primary Reason:**
- [ ] Mission-critical application incompatibility
- [ ] Legacy system technical limitation
- [ ] Vendor-imposed constraint
- [ ] Hardware architecture limitation
- [ ] Operational requirement conflict
- [ ] Other (specify below)

### Detailed Technical Explanation

[Provide comprehensive technical explanation of why the STIG requirement cannot be implemented]

**Example:**
```
The legacy medical imaging application (MedView v4.2) is critical to patient care 
operations and requires local administrator privileges to function. The application 
was designed in 2015 and attempts to write directly to HKLM registry keys and 
C:\Program Files\ directories during normal operation.

Enabling UAC virtualization (as required by V-220706) causes the application to 
crash on startup with error code 0x80070005 (Access Denied). The vendor (MedTech 
Solutions) has confirmed that their legacy v4.x product line does not support UAC 
and will not receive updates to add this capability.

Migration to the UAC-compatible v6.x version is planned but requires:
1. Budget approval ($850K) - submitted for FY26
2. Clinical workflow redesign (6 months)
3. Staff retraining (3 months)
4. Data migration and validation (2 months)

Estimated completion: Q3 FY26 (September 2026)
```

### Impact Assessment if Requirement Were Enforced

[Describe the operational impact if this requirement were enforced despite the technical limitation]

**Example:**
```
If UAC virtualization were enabled:
- 45 clinical workstations would lose access to patient imaging
- Emergency department unable to view X-rays/CT scans
- Estimated 120 patients per day affected
- Potential patient safety impact requiring immediate rollback
```

---

## Risk Assessment

### Vulnerability Description

[Describe the security vulnerability that exists due to non-compliance]

**Example:**
```
Without UAC virtualization enabled, the MedView application runs with full local 
administrator privileges. This creates several risks:

1. Privilege Escalation: If the application is compromised, an attacker gains 
   local admin privileges without UAC prompting
2. Lateral Movement: Compromised workstation could be used to attack other systems
3. Data Modification: Attacker could modify system files, registry, or installed 
   applications without restriction
4. Malware Installation: Silent installation of malware without user awareness
```

### Likelihood Assessment

**Likelihood Rating:** [Low / Moderate / High]

**Justification:**
```
Likelihood: MODERATE

Factors increasing likelihood:
- Application processes external data (DICOM images from multiple sources)
- 45 systems affected increases attack surface
- Healthcare sector is high-value target for ransomware

Factors decreasing likelihood:
- Systems are on isolated VLAN with restricted internet access
- Application has limited network communication (receives images only)
- No identified vulnerabilities in MedView v4.2 currently
```

### Impact Assessment

**Impact Rating:** [Low / Moderate / High]

**Justification:**
```
Impact: HIGH

If exploitation occurs:
- Confidentiality: HIGH - Access to Protected Health Information (PHI) for 
  ~10,000 patients
- Integrity: HIGH - Ability to modify patient imaging data
- Availability: MODERATE - Could disrupt emergency medical imaging services

System categorization: HIGH-HIGH-MODERATE
```

### Overall Risk Level

**Risk Level:** [Low / Moderate / High / Very High]

**Calculation:** [Likelihood × Impact]

```
MODERATE likelihood × HIGH impact = HIGH RISK

This risk level exceeds organizational risk tolerance and requires compensating 
controls to reduce to acceptable level (Moderate or below).
```

---

## Compensating Controls

### Compensating Control #1: Network Segmentation

**Control Description:**
```
All 45 clinical workstations running MedView are isolated on a dedicated VLAN 
(VLAN 150 - Medical Imaging) with strict access control lists (ACLs).
```

**Technical Implementation:**
- VLAN 150 isolated from general user network
- Firewall rules permitting only:
  - Inbound: DICOM traffic from imaging devices (ports 104, 11112) from VLAN 200
  - Outbound: Print services to medical printer VLAN 175
  - Outbound: Windows Update (ports 80, 443) to WSUS server only
- All other traffic blocked by default (implicit deny)

**Risk Reduction:**
```
This control reduces the likelihood of compromise by limiting:
- Attack surface (minimal inbound traffic)
- Lateral movement potential (outbound restrictions)
- Internet-based threats (no direct internet access)

Estimated Risk Reduction: 30% reduction in likelihood
```

**Evidence:**
- Firewall configuration export: [Link to artifact]
- Network diagram showing VLAN segmentation: [Link to diagram]
- ACL verification scan results: [Link to scan]

---

### Compensating Control #2: Enhanced Monitoring and Logging

**Control Description:**
```
Deployed Windows Event Forwarding (WEF) and Sysmon on all affected workstations 
to provide enhanced detection capabilities for privilege escalation and malicious 
activity.
```

**Technical Implementation:**
- Sysmon v14.16 configured with SwiftOnSecurity ruleset
- Logs forwarded to centralized SIEM (Splunk Enterprise Security)
- Custom correlation rules for:
  - Unexpected process execution from MedView directory
  - Registry modifications outside normal MedView operation
  - Network connections to unauthorized destinations
  - Privilege escalation attempts
- Alert thresholds configured with 15-minute response SLA

**Risk Reduction:**
```
This control reduces impact by enabling:
- Rapid detection of exploitation attempts (avg 5 minutes)
- Automated alerting to security team
- Forensic evidence collection for incident response
- Ability to isolate compromised system within 15 minutes

Estimated Risk Reduction: 40% reduction in impact severity
```

**Evidence:**
- Sysmon configuration file: [Link to config]
- SIEM correlation rule screenshots: [Link to screenshots]
- Sample alert and response test: [Link to test results]

---

### Compensating Control #3: Application Whitelisting

**Control Description:**
```
Implemented Windows Defender Application Control (WDAC) policies on all affected 
workstations to restrict executable code to authorized applications only.
```

**Technical Implementation:**
- WDAC policy allows only:
  - Signed Windows components
  - MedView application and dependencies (hash-based rules)
  - Approved administrative tools (code signing certificate rules)
- Policy enforced in enforcement mode (blocks unauthorized executables)
- Policy updates managed via GPO from centralized repository

**Risk Reduction:**
```
This control reduces impact by preventing:
- Execution of malware/ransomware even if downloaded
- Unauthorized tool execution (e.g., Mimikatz, PSExec)
- Script-based attacks (PowerShell, VBScript restricted)

Estimated Risk Reduction: 50% reduction in exploitation impact
```

**Evidence:**
- WDAC policy XML: [Link to policy]
- Application inventory baseline: [Link to inventory]
- Policy enforcement test results: [Link to tests]

---

### Compensating Control #4: Physical Access Control

**Control Description:**
```
Clinical workstations are located in badge-controlled clinical areas with 
surveillance and access logging.
```

**Technical Implementation:**
- All systems in areas requiring CAC/PIV badge access
- Video surveillance with 90-day retention
- Access logs reviewed weekly by facility security
- Systems configured to auto-lock after 10 minutes inactivity

**Risk Reduction:**
```
This control reduces likelihood by limiting:
- Physical access to authorized medical personnel only
- Ability for unauthorized users to exploit local admin privileges
- Risk of insider threat through access monitoring

Estimated Risk Reduction: 20% reduction in likelihood
```

**Evidence:**
- Physical security assessment report: [Link to report]
- Access control system logs: [Link to logs]
- Badge reader locations and coverage: [Link to diagram]

---

### Compensating Control #5: Restricted Local Admin Group

**Control Description:**
```
Local administrator group membership is tightly controlled and monitored. The 
MedView service account is the only member beyond the default Administrator account 
(which is disabled).
```

**Technical Implementation:**
- GPO enforces restricted group membership
- Daily automated checks for unauthorized additions
- Service account password rotated quarterly (120-day interval)
- Service account has "Deny log on locally" and "Deny network access" rights
- Account can only be used by MedView service, not interactive logon

**Risk Reduction:**
```
This control reduces impact by ensuring:
- Service account cannot be used for interactive exploitation
- Unauthorized privilege escalation detected within 24 hours
- Limited credential exposure

Estimated Risk Reduction: 30% reduction in exploitation potential
```

**Evidence:**
- GPO restricted groups configuration: [Link to GPO]
- Service account permission audit: [Link to audit]
- Automated monitoring script and alerts: [Link to script]

---

## Combined Risk Reduction Analysis

### Original Risk Assessment
- **Likelihood:** Moderate
- **Impact:** High
- **Overall Risk:** HIGH

### With Compensating Controls
- **Likelihood Reduction:** ~50% (network segmentation + physical access + monitoring detection)
- **Impact Reduction:** ~60% (application whitelisting + monitoring + restricted admin)
- **Residual Risk:** MODERATE

**Justification:**
```
The combination of five layered compensating controls provides defense-in-depth 
that significantly reduces both the likelihood and impact of exploitation:

1. Network segmentation makes initial compromise more difficult
2. Application whitelisting prevents malware execution even if system is accessed
3. Enhanced monitoring enables rapid detection and response
4. Physical access controls limit attack vectors
5. Restricted admin group minimizes privilege escalation potential

While the original STIG requirement cannot be met, the compensating controls 
provide equivalent or superior risk reduction through multiple defensive layers.

Residual MODERATE risk is within organizational risk tolerance as documented in 
the System Security Plan Section 13 (Risk Management).
```

---

## Plan of Action and Milestones (POA&M)

### Long-Term Remediation Plan

**Goal:** Achieve full STIG compliance by migrating to UAC-compatible application version

**Milestones:**

| Milestone | Description | Responsible Party | Target Date | Status |
|-----------|-------------|-------------------|-------------|--------|
| 1 | Budget approval for MedView v6.x | IT Director | Oct 2025 | In Progress |
| 2 | Vendor contract execution | Procurement | Dec 2025 | Planned |
| 3 | Clinical workflow analysis | Clinical IT Lead | Feb 2026 | Planned |
| 4 | Test environment deployment | System Admin | Apr 2026 | Planned |
| 5 | User acceptance testing | Clinical Staff | Jun 2026 | Planned |
| 6 | Production migration (Phase 1: 10 systems) | System Admin | Jul 2026 | Planned |
| 7 | Production migration (Phase 2: remaining 35 systems) | System Admin | Sep 2026 | Planned |
| 8 | Enable UAC and verify compliance | ISSO | Oct 2026 | Planned |
| 9 | Close POA&M | ISSO | Oct 2026 | Planned |

**Dependencies:**
- FY26 budget approval
- Vendor delivery timeline (6-8 weeks lead time)
- Clinical staff availability for training

**Interim Milestones (Compensating Controls):**

| Milestone | Description | Responsible Party | Completion Date | Status |
|-----------|-------------|-------------------|-----------------|--------|
| 1 | VLAN segmentation deployment | Network Admin | Jan 15, 2025 | Complete |
| 2 | Sysmon and SIEM integration | Security Engineer | Jan 22, 2025 | Complete |
| 3 | WDAC policy deployment | System Admin | Feb 5, 2025 | Complete |
| 4 | Physical access control validation | Facility Security | Feb 10, 2025 | Complete |
| 5 | Restricted admin group enforcement | System Admin | Feb 12, 2025 | Complete |

---

## Review and Approval

### ISSO Recommendation

**Recommendation:** ACCEPT RISK with compensating controls

**Justification:**
```
Based on the comprehensive technical analysis and implemented compensating controls, 
I recommend accepting the residual MODERATE risk for the following reasons:

1. Compensating controls provide defense-in-depth that reduces risk to acceptable level
2. Controls are technically verified and actively monitored
3. Long-term remediation plan is funded and on track
4. Mission criticality justifies temporary deviation with enhanced controls
5. Residual risk is within organizational tolerance per SSP Section 13

This approach balances security requirements with operational mission needs while 
maintaining an acceptable security posture.
```

**ISSO Signature:** _________________________ **Date:** _____________  
[ISSO Name], Information System Security Officer

---

### ISSM Review

**Review Comments:**
```
[ISSM provides assessment of risk acceptance recommendation]
```

**Decision:** [ ] APPROVE    [ ] DISAPPROVE    [ ] APPROVE WITH CONDITIONS

**Conditions (if applicable):**
```
[Any additional requirements or conditions for risk acceptance]
```

**ISSM Signature:** _________________________ **Date:** _____________  
[ISSM Name], Information System Security Manager

---

### System Owner Acknowledgment

**Operational Impact Statement:**
```
[System Owner confirms understanding of residual risk and operational impact]
```

**System Owner Signature:** _________________________ **Date:** _____________  
[System Owner Name], System Owner

---

## Continuous Monitoring and Review

### Monitoring Requirements

**Monthly Review Items:**
- VLAN ACL configuration verification
- SIEM alert review and false positive analysis
- WDAC policy compliance scan
- Service account audit log review
- POA&M milestone progress tracking

**Quarterly Review Items:**
- Full compensating control effectiveness assessment
- Risk re-assessment based on threat landscape changes
- Physical security access log audit
- Service account password rotation
- Budget and timeline review for long-term remediation

**Annual Review Items:**
- Complete re-validation of compensating controls
- Update risk assessment with current threat intelligence
- Reassess residual risk level
- Review long-term remediation plan and adjust timeline if needed

### Review Schedule

| Review Type | Frequency | Next Review Date | Responsible Party |
|-------------|-----------|------------------|-------------------|
| Compensating Control Status | Monthly | [First of each month] | ISSO |
| Risk Re-assessment | Quarterly | [Quarterly dates] | ISSO/ISSM |
| POA&M Progress | Monthly | [First of each month] | ISSO |
| Full Documentation Review | Annually | [Anniversary date] | ISSO/ISSM |

---

## Appendices

### Appendix A: Supporting Documentation
- Network diagram showing VLAN segmentation
- Firewall ACL configuration exports
- Sysmon configuration file
- WDAC policy XML
- Service account audit results
- Physical security assessment

### Appendix B: Evidence Artifacts
- SCAP scan results showing non-compliance
- STIG Viewer checklist entry
- GPO configuration screenshots
- SIEM correlation rule screenshots
- Monitoring dashboard examples

### Appendix C: Vendor Documentation
- MedTech Solutions UAC incompatibility statement
- Product end-of-life notice for v4.x
- Migration guide to v6.x
- Cost estimate for upgrade

### Appendix D: References
- NIST SP 800-53 Rev 5 Control Catalog
- DISA STIG for Windows 11 V1R5
- Organization Risk Management Framework
- System Security Plan (SSP) Section 13

---

**Document Version:** 1.0  
**Last Updated:** [Date]  
**Next Review Date:** [Date]  
**Classification:** CONTROLLED UNCLASSIFIED INFORMATION (CUI)
