# STIG Compliance Documentation Templates

This directory contains professional templates for documenting STIG compliance activities, risk management decisions, and continuous monitoring processes.

---

## 📋 Available Templates

### **Compensating Control Documentation**
**File:** `compensating-control-template.md`

**Purpose:** Document risk-based deviations from STIG requirements using approved compensating controls

**Use When:**
- STIG requirement cannot be technically implemented
- Mission-critical application has compatibility issues
- Legacy system has technical limitations
- Vendor-imposed constraints prevent compliance
- Operational requirements conflict with STIG settings

**Key Sections:**
- Control information and STIG mapping
- Technical justification for non-compliance
- Risk assessment (likelihood × impact)
- Detailed compensating control descriptions
- Evidence and validation approach
- ISSM/ISSO approval workflow

**Template Features:**
- Pre-formatted risk matrices
- Sample content and examples
- NIST 800-53 control mapping
- Complete approval signature blocks
- Continuous monitoring requirements

---

### **Plan of Action and Milestones (POA&M)**
**File:** `poam-entry-template.md`

**Purpose:** Track findings requiring extended remediation timelines with detailed milestones and progress monitoring

**Use When:**
- Finding cannot be immediately remediated
- Multi-phase remediation approach required
- Budget approval needed before remediation
- Vendor coordination required
- Long-term technical upgrades planned

**Key Sections:**
- Finding source and details
- NIST 800-53 and STIG mapping
- Risk assessment and prioritization
- Short-term compensating controls
- Long-term remediation strategy
- Detailed milestone tracking
- Resource requirements and dependencies
- Monthly progress certification

**Template Features:**
- Milestone tracking tables
- Change log for timeline adjustments
- Evidence artifact checklists
- Closure criteria and verification
- Lessons learned documentation

---

### **Monthly Status Report**
**File:** `monthly-status-report-template.md`

**Purpose:** Executive-level compliance reporting for continuous monitoring and stakeholder communication

**Use When:**
- Monthly reporting cycle
- ISSM/System Owner updates required
- Assessment preparation
- Leadership briefings
- Continuous monitoring documentation

**Key Sections:**
- Executive summary with key metrics
- Compliance dashboard and trends
- Platform-specific breakdown
- Remediation activity summary
- POA&M status and progress
- GPO health and drift detection
- Upcoming activities and priorities

**Template Features:**
- Pre-formatted compliance tables
- Month-over-month trend analysis
- Visual dashboard layouts
- Risk assessment summaries
- Action item tracking

---

## 🚀 Quick Start Guide

### Using the Templates

1. **Copy the template file:**
```bash
cp compensating-control-template.md compensating-control-UAC-legacy-app.md
```

2. **Fill in bracketed placeholders:**
```markdown
**System Name:** [Enter system name]  ← Replace with "Medical Imaging System"
**STIG ID:** [e.g., V-220706]          ← Replace with actual STIG ID
```

3. **Remove example content:**
- Templates include examples in code blocks
- Read examples to understand expected content
- Delete example blocks and replace with your actual content

4. **Complete all sections:**
- Don't skip sections - they're all important
- Use "N/A" only if truly not applicable
- Provide specific details, not generic statements

5. **Obtain required approvals:**
- Follow your organization's approval workflow
- Get ISSM sign-off before implementation
- Document approval dates

---

## 📖 Usage Examples

### Example 1: Documenting a Compensating Control

**Scenario:** Legacy medical application incompatible with UAC virtualization

**Steps:**
1. Copy `compensating-control-template.md` to `compensating-control-medview-uac.md`
2. Fill in STIG details: V-220706, Windows 11 STIG V1R5
3. Document technical justification: Application crashes when UAC enabled
4. Perform risk assessment: Moderate likelihood × High impact = HIGH risk
5. Document compensating controls:
   - Network segmentation (VLAN isolation)
   - Enhanced monitoring (Sysmon + SIEM)
   - Application whitelisting (WDAC)
   - Physical access controls
   - Restricted admin group
6. Calculate residual risk: Compensating controls reduce to MODERATE
7. Create POA&M for long-term remediation (app upgrade)
8. Obtain ISSM approval
9. Upload to eMASS with all evidence

---

### Example 2: Creating a POA&M

**Scenario:** RHEL 8 systems require SELinux policy updates from vendor

**Steps:**
1. Copy `poam-entry-template.md` to `poam-2026-003-selinux-policy.md`
2. Document finding source: Monthly SCAP scan, 15 findings across 13 systems
3. Enter STIG details: RHEL 8 STIG V1R9, various V-IDs
4. Assess risk: Low likelihood × Moderate impact = LOW risk
5. Document short-term compensating controls: Enhanced audit logging, network segmentation
6. Create remediation plan:
   - Milestone 1: Engage vendor (complete)
   - Milestone 2: Receive updated policy (Feb 15)
   - Milestone 3: Test in lab (Feb 20)
   - Milestone 4: Deploy to production (Mar 1)
   - Milestone 5: Verify compliance (Mar 5)
7. Set scheduled completion: March 5, 2026
8. Document resource needs: 20 hours admin time, vendor support hours
9. Get ISSM approval
10. Enter into eMASS POA&M module

---

### Example 3: Monthly Status Report

**Scenario:** Routine continuous monitoring report for January 2026

**Steps:**
1. Copy `monthly-status-report-template.md` to `status-report-2026-01.md`
2. Update report header: January 2026, report date, ISSO name
3. Execute monthly SCAP scan (Jan 15)
4. Import results and calculate metrics:
   - Overall compliance: 94.2%
   - CAT I: 100%, CAT II: 93.8%, CAT III: 91.5%
5. Document findings breakdown: 142 open (98 CAT II, 44 CAT III)
6. Compare to last month: +2.1% improvement, 18 findings closed
7. Update platform-specific sections (Windows, Linux, Network)
8. Document remediation activity: 18 findings closed, methods used
9. Update all POA&M statuses (9 on track, 3 at risk, 0 overdue)
10. Document GPO health: 99.3% application success, 2 drift incidents
11. Add upcoming activities and maintenance windows
12. Obtain ISSM review
13. Distribute to stakeholders

---

## ✅ Best Practices

### General Guidelines

**Be Specific, Not Generic:**
```
❌ Bad: "Implemented additional controls"
✅ Good: "Implemented network segmentation on VLAN 150 with ACLs 
         permitting only DICOM traffic (ports 104, 11112) from 
         VLAN 200 imaging devices"
```

**Use Evidence-Based Statements:**
```
❌ Bad: "System is properly configured"
✅ Good: "Verified registry key HKLM\System\CurrentControlSet\
         Control\Lsa\LimitBlankPasswordUse = 1 via PowerShell 
         command executed 01/15/2026"
```

**Quantify Everything:**
```
❌ Bad: "Many systems affected"
✅ Good: "45 clinical workstations (28% of total Windows 11 fleet)"
```

**Document Dates:**
```
❌ Bad: "Recently implemented"
✅ Good: "Implemented on January 15, 2026"
```

---

### Compensating Control Best Practices

1. **Multiple Layers Preferred:**
   - Single compensating control is weak
   - Implement 3-5 layered controls
   - Defense in depth approach

2. **Align to Control Intent:**
   - Understand WHY the STIG requirement exists
   - Ensure compensating controls address same risk
   - Don't just implement unrelated "security stuff"

3. **Make Controls Measurable:**
   - Include specific metrics
   - Define verification methods
   - Schedule regular reviews

4. **Document Residual Risk:**
   - Be honest about remaining risk
   - Show how controls reduce risk to acceptable level
   - Don't claim zero risk

---

### POA&M Best Practices

1. **Realistic Timelines:**
   - Don't promise what you can't deliver
   - Include buffer time for delays
   - Better to finish early than extend repeatedly

2. **Identify Dependencies Early:**
   - Budget approvals
   - Vendor timelines
   - Resource availability
   - Technical constraints

3. **Milestone Granularity:**
   - Break large efforts into 30-60 day milestones
   - Each milestone should be verifiable
   - Avoid single milestone for 6+ month effort

4. **Update Regularly:**
   - Monthly updates minimum
   - Update immediately when delays occur
   - Document reasons for changes

---

### Status Report Best Practices

1. **Consistent Format:**
   - Use same template every month
   - Enables trend comparison
   - Builds stakeholder familiarity

2. **Executive-Friendly Summary:**
   - Start with key metrics and highlights
   - Use visual elements (tables, trends)
   - Detail sections come after summary

3. **Honest Assessment:**
   - Report problems openly
   - Include mitigation plans for issues
   - Credibility comes from transparency

4. **Forward-Looking:**
   - Don't just report past
   - Include upcoming activities
   - Set expectations for next month

---

## 🎯 Customization Tips

### Adapting for Your Organization

**Add Organization-Specific Sections:**
```markdown
## Organizational Compliance Requirements

**DoD Component Policy:** [Reference specific policy]
**Local Security Procedures:** [Reference local SOP]
**Additional Requirements:** [List any additional requirements]
```

**Modify Approval Workflow:**
```markdown
### Approval Chain

1. ISSO Recommendation: [Name, Date]
2. ISSM Review: [Name, Date]
3. System Owner Acknowledgment: [Name, Date]
4. [Add additional approvers as needed]
5. AO Approval: [Name, Date] ← Add if required
```

**Adjust Risk Matrices:**
- Some organizations use 5x5 matrices instead of 3x3
- Adjust impact definitions (DoD vs. civilian agency)
- Change risk level labels (Very High/High/Moderate/Low vs. 1/2/3/4)

---

## 📊 Template Metrics

### Compensating Control Template
- **Typical Completion Time:** 4-6 hours (first time), 2-3 hours (subsequent)
- **Sections:** 15 major sections
- **Average Length:** 12-18 pages when complete
- **Approval Timeline:** 1-2 weeks typical

### POA&M Template
- **Typical Completion Time:** 2-3 hours
- **Sections:** 11 major sections
- **Average Length:** 6-10 pages when complete
- **Update Frequency:** Monthly minimum

### Monthly Status Report
- **Typical Completion Time:** 3-4 hours
- **Sections:** 14 major sections
- **Average Length:** 15-20 pages when complete
- **Frequency:** Monthly

---

## 📁 Document Management

### File Naming Conventions

**Recommended Format:**
```
compensating-control-[SYSTEM]-[STIG-ID]-[DESCRIPTION].md
poam-[YEAR]-[NUMBER]-[SHORT-DESCRIPTION].md
status-report-[YEAR]-[MONTH].md
```

**Examples:**
```
compensating-control-MedView-V220706-UAC-Virtualization.md
poam-2026-003-SELinux-Policy-Update.md
status-report-2026-01.md
```

### Version Control

**Track Major Changes:**
```markdown
## Document Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 01/15/2026 | J. Smith | Initial creation |
| 1.1 | 02/20/2026 | J. Smith | Updated risk assessment, added Control #5 |
| 2.0 | 03/10/2026 | J. Smith | ISSM requested additional evidence |
```

### Storage and Backup

**Recommended Locations:**
- **Working Copies:** Local workstation
- **Official Versions:** eMASS (system of record)
- **Backup Copies:** SharePoint/Confluence
- **Version Control:** Git repository (sanitize sensitive data)

---

## 🔒 Handling Sensitive Information

### Sanitization Guidelines

**Before sharing templates externally:**
```markdown
Remove:
- System names (replace with "System A")
- IP addresses (replace with "10.0.0.x")
- Personnel names (replace with "ISSO" or role)
- Organization names (replace with "Organization")
- Specific vulnerabilities in production (generalize)
- Proprietary vendor information
```

**Classification Markings:**
```markdown
Add appropriate markings:
- CONTROLLED UNCLASSIFIED INFORMATION (CUI)
- FOUO (For Official Use Only)
- Or organization-specific markings
```

---

## 🆘 Support and Questions

### Common Questions

**Q: Do I need to fill out every section?**  
A: Yes, unless specifically marked "if applicable." Each section serves a purpose for risk management or assessment.

**Q: Can I delete the example content?**  
A: Yes, examples are for guidance only. Delete and replace with your actual content.

**Q: What if my organization has different approval requirements?**  
A: Customize the approval section to match your organization's workflow.

**Q: How detailed should the technical justification be?**  
A: Detailed enough that an assessor unfamiliar with your system understands exactly why compliance isn't possible.

**Q: What's the difference between compensating control and POA&M?**  
A: Compensating control accepts long-term deviation with alternate controls. POA&M tracks remediation to eventually achieve full compliance.

---

## 📚 Additional Resources

**DoD Resources:**
- RMF Knowledge Service: https://rmf.org
- DoD Instruction 8510.01: Risk Management Framework
- DISA Security Technical Implementation Guides: https://public.cyber.mil/stigs/

**NIST Resources:**
- SP 800-53 Rev 5: Security and Privacy Controls
- SP 800-37 Rev 2: Risk Management Framework
- SP 800-137: Information Security Continuous Monitoring

**Templates and Guides:**
- eMASS User Guide (access through DISA)
- Your organization's RMF process guide
- ISSM desk reference materials

---

## 🤝 Contributing

Improvements to these templates are welcome!

**Suggested Enhancements:**
- Additional example scenarios
- Organization-specific customizations
- Improved formatting for readability
- Automated data population scripts
- Integration with eMASS export formats

Submit pull requests or open issues for discussion.

---

**Last Updated:** January 2026  
**Maintained by:** ISSO Security Team  
**License:** MIT (see repository LICENSE file)
