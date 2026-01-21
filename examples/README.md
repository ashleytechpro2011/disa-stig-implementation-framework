# STIG Compliance Examples and Samples

This directory contains real-world examples and sample artifacts demonstrating STIG implementation best practices. All examples have been sanitized to remove sensitive organizational data.

---

## 📁 Directory Structure

```
examples/
├── stig-checklists/          # Sample completed STIG Viewer checklists
├── gpo-configs/              # Group Policy Object exports and documentation
├── compensating-controls/    # Real-world compensating control examples
├── scan-results/             # Sample SCAP scan outputs (anonymized)
└── poam-examples/            # Example POA&M entries for common scenarios
```

---

## 🎯 Purpose

These examples serve multiple purposes:

**For Learning:**
- Understand what complete artifacts look like
- See how to document technical details properly
- Learn from real-world implementation scenarios

**For Reference:**
- Compare your work against proven examples
- Identify documentation gaps in your own artifacts
- Understand level of detail expected by assessors

**For Templates:**
- Use as starting points for similar scenarios
- Copy structure and adapt to your environment
- Maintain consistent quality across your documentation

---

## 📋 Available Examples

### **STIG Checklists** (`stig-checklists/`)

**Status:** Coming Soon

**Planned Content:**
- `windows11-stig-v1r5-sample.ckl` - Complete Windows 11 STIG checklist showing:
  - Passed findings with evidence
  - Failed findings with remediation plans
  - Not Applicable findings with justifications
  - Manual validation documentation

- `rhel8-stig-v1r9-sample.ckl` - Complete RHEL 8 STIG checklist demonstrating:
  - Configuration file evidence
  - Command output documentation
  - SELinux and kernel parameter validation
  - Service configuration verification

---

### **Group Policy Configurations** (`gpo-configs/`)

**Status:** Coming Soon

**Planned Content:**
- `STIG_Windows11_v1r5_GPO/` - Complete GPO export including:
  - Registry policy settings
  - Security settings
  - Administrative templates
  - Audit policy configuration
  - Documentation of each setting's purpose

- `gpo-documentation-sample.md` - Example showing how to document:
  - GPO purpose and scope
  - Settings implementation details
  - STIG requirement mappings
  - Testing and validation results
  - Deployment timeline and scope

---

### **Compensating Controls** (`compensating-controls/`)

**Status:** Coming Soon

**Planned Content:**

**Example 1: Legacy Application Incompatibility**
- STIG requirement that breaks legacy medical software
- Multi-layered compensating controls
- Risk reduction calculations
- Long-term remediation plan (POA&M)

**Example 2: Hardware Limitation**
- Embedded system that cannot be reconfigured
- Physical and network-based compensating controls
- Lifecycle management approach
- Replacement timeline

**Example 3: Vendor Constraint**
- Cloud service provider limitation
- Contractual compensating controls
- Shared responsibility model documentation
- Third-party attestation approach

---

### **SCAP Scan Results** (`scan-results/`)

**Status:** Coming Soon

**Planned Content:**
- `sample-scap-output.xml` - Anonymized SCAP scan result showing:
  - XCCDF/XML format structure
  - Pass/Fail/NotApplicable results
  - Vulnerability severity ratings
  - Check content and rationale

- `scan-results-analysis.md` - Guide explaining:
  - How to interpret SCAP output
  - Common false positives
  - Mapping results to STIG Viewer
  - Trending and comparison techniques

---

### **POA&M Examples** (`poam-examples/`)

**Status:** Coming Soon

**Planned Content:**

**Common Scenarios:**
1. Budget-constrained remediation (requires funding approval)
2. Vendor-dependent fix (waiting on vendor patch)
3. Multi-phase migration (complex system upgrade)
4. Resource-limited remediation (competing priorities)
5. Technical impossibility (permanent compensating control)

---

## 🚀 How to Use These Examples

### For New ISSOsSecurity Practitioners

1. **Start by reviewing complete examples:**
   - See what "good" looks like
   - Understand expected level of detail
   - Identify sections you might overlook

2. **Compare against your draft work:**
   - Is your evidence as specific?
   - Are your justifications as detailed?
   - Have you documented everything required?

3. **Adapt examples to your scenario:**
   - Copy structure, not content
   - Customize technical details
   - Maintain same quality standard

---

### For Experienced Practitioners

1. **Use as quality benchmarks:**
   - Ensure your team's work meets these standards
   - Identify training gaps for junior staff
   - Standardize documentation across your program

2. **Extract reusable patterns:**
   - Common compensating control approaches
   - Standard GPO configurations
   - Typical risk assessment language

3. **Contribute your own examples:**
   - Share lessons learned
   - Document unique scenarios
   - Help the community

---

## 📖 Detailed Example Walkthroughs

### Example: Compensating Control for UAC Incompatibility

**Scenario:**
Legacy medical imaging application (MedView v4.2) requires local administrator privileges and crashes when User Account Control (UAC) virtualization is enabled per STIG V-220706.

**Why This Example Matters:**
- Common real-world scenario
- Demonstrates risk-based decision making
- Shows multi-layered compensating control approach
- Includes long-term remediation plan

**What You'll Learn:**
1. How to perform technical root cause analysis
2. Proper risk assessment methodology
3. Designing defense-in-depth compensating controls
4. Documenting for ISSM approval
5. Creating linked POA&M for long-term fix

**Key Takeaways:**
- Five layered compensating controls reduce HIGH risk to MODERATE
- Network segmentation + application whitelisting most effective
- Enhanced monitoring enables rapid incident response
- Long-term remediation (app upgrade) required, not just acceptance

---

### Example: RHEL 8 Complete STIG Checklist

**Scenario:**
Production RHEL 8 web server hosting internal application, requiring compliance with RHEL 8 STIG V1R9.

**Why This Example Matters:**
- Shows manual validation documentation
- Demonstrates configuration file evidence
- Illustrates command output as proof
- Includes Not Applicable justifications

**What You'll Learn:**
1. How to document manual STIG validation
2. Proper evidence collection and formatting
3. Writing clear technical justifications
4. When and how to mark findings Not Applicable
5. Organizing evidence for assessor review

**Key Takeaways:**
- SCAP automated 70% of checks
- Manual validation required detailed documentation
- Configuration files provide better evidence than screenshots
- Command output must include timestamps and system identification

---

## ⚙️ Customizing Examples for Your Environment

### Sanitization Checklist

Before using examples, replace:

- [ ] System names → Your system names
- [ ] IP addresses → Your IP ranges
- [ ] Organization names → Your organization
- [ ] Personnel names → Your staff
- [ ] Specific applications → Your applications
- [ ] Network details → Your network architecture
- [ ] Dates → Current dates
- [ ] Scan tool versions → Your tool versions
- [ ] STIG versions → Current STIG versions

### Adding Your Context

Enhance examples with:

- Your organization's risk tolerance
- Your approval workflow requirements
- Your technical architecture details
- Your specific compliance requirements
- Your stakeholder communication needs

---

## 🎓 Learning Path

### Beginner Path

1. **Read:** Review compensating control example
2. **Understand:** Study the risk assessment methodology
3. **Practice:** Apply template to a simple finding
4. **Compare:** Check your work against example
5. **Improve:** Refine based on comparison

### Intermediate Path

1. **Analyze:** Deep dive into GPO configuration example
2. **Implement:** Deploy similar GPO in test environment
3. **Document:** Create documentation matching example quality
4. **Validate:** Ensure your evidence is equivalent
5. **Deploy:** Roll out to production

### Advanced Path

1. **Synthesize:** Combine multiple example approaches
2. **Innovate:** Develop novel compensating controls
3. **Contribute:** Create new examples for community
4. **Mentor:** Teach others using these examples
5. **Standardize:** Build your organization's example library

---

## 📊 Example Quality Standards

All examples in this directory meet these criteria:

**Technical Accuracy:**
- ✅ Aligned with current DISA STIG guidance
- ✅ Technically feasible and tested
- ✅ Reflects real-world implementations
- ✅ Uses current tool versions and formats

**Documentation Quality:**
- ✅ Complete (no missing sections)
- ✅ Specific (concrete details, not generic)
- ✅ Evidence-based (includes verification)
- ✅ Professional (proper formatting and grammar)

**Assessment-Ready:**
- ✅ Would pass assessor review
- ✅ Includes sufficient evidence
- ✅ Properly formatted for eMASS
- ✅ Demonstrates risk management

---

## 🔍 What Makes a Good Example?

### Good Example Characteristics

**Specific and Detailed:**
```
✅ Good Example:
"VLAN 150 isolated from general network with Cisco ASA firewall enforcing 
ACL 'MEDICAL_IMAGING' permitting only inbound DICOM traffic (TCP ports 
104, 11112) from VLAN 200 (radiology equipment). All other traffic 
blocked via implicit deny. Configuration verified via 'show access-list 
MEDICAL_IMAGING' on 01/15/2026."

❌ Bad Example:
"Network segmentation implemented for security."
```

**Evidence-Based:**
```
✅ Good Example:
"Verified via PowerShell command: Get-ItemProperty 'HKLM:\System\
CurrentControlSet\Control\Lsa' -Name 'LimitBlankPasswordUse' returned 
value: 1 (compliant). Screenshot saved as evidence artifact 
LimitBlankPasswordUse-verification-20260115.png."

❌ Bad Example:
"Password settings are configured correctly."
```

**Risk-Aware:**
```
✅ Good Example:
"Residual risk assessment: MODERATE likelihood (network segmentation 
reduces external attack surface but insider threat remains) × HIGH 
impact (PHI exposure) = MODERATE overall risk. This is within 
organizational risk tolerance per SSP Section 13."

❌ Bad Example:
"Risk is acceptable."
```

---

## 📁 File Organization Best Practices

### Naming Conventions

**For Checklists:**
```
[PLATFORM]-stig-[VERSION]-[SYSTEM]-[DATE].ckl

Example:
rhel8-stig-v1r9-webserver01-20260115.ckl
```

**For Compensating Controls:**
```
compensating-control-[FINDING-ID]-[SHORT-DESC].md

Example:
compensating-control-V220706-uac-legacy-app.md
```

**For Scan Results:**
```
scap-[PLATFORM]-[SYSTEM]-[DATE].xml

Example:
scap-windows11-workstation-pool-20260115.xml
```

---

## 🆘 Common Mistakes to Avoid

### Documentation Anti-Patterns

**❌ Vague Justifications:**
```
Bad: "This finding doesn't apply to our system."
Good: "Finding V-220706 requires UAC virtualization, which is a Windows-
specific control. This system runs RHEL 8 and does not have UAC 
functionality. Marked Not Applicable per STIG guidance for 
non-Windows platforms."
```

**❌ Missing Evidence:**
```
Bad: "Configuration verified as compliant."
Good: "Configuration verified via command output (attached as 
evidence-selinux-status-20260115.txt) showing SELinux in enforcing 
mode: 'SELinux status: enabled, Current mode: enforcing, Mode from 
config file: enforcing'."
```

**❌ Generic Compensating Controls:**
```
Bad: "Additional monitoring implemented."
Good: "Deployed Sysmon v14.16 with SwiftOnSecurity ruleset to collect 
process creation, network connections, and file modifications. Events 
forwarded to Splunk Enterprise Security with custom correlation rules 
alerting on privilege escalation attempts (SPL query: index=windows 
EventCode=4672 OR EventCode=4673 | stats count by host user)."
```

---

## 🤝 Contributing Examples

### Submission Guidelines

**What We're Looking For:**
- Real-world scenarios (anonymized)
- Complete documentation packages
- Novel approaches to common problems
- Lessons learned from assessments
- Assessment-approved artifacts

**How to Contribute:**
1. Sanitize all organizational data
2. Ensure examples follow quality standards
3. Add explanatory documentation
4. Submit via pull request
5. Include lessons learned section

**What to Include:**
- Complete artifact (checklist, GPO export, etc.)
- README explaining scenario
- Key learning points
- Challenges encountered
- Assessment outcome (if applicable)

---

## 📚 Additional Resources

**DISA Resources:**
- STIG Viewer User Guide
- SCAP Content Repository
- eMASS User Documentation

**Community Resources:**
- DoD Cyber Exchange: https://public.cyber.mil
- RMF Knowledge Service: https://rmf.org
- NIST SCAP Content Repository: https://scap.nist.gov

**Training:**
- DISA STIG Training
- eMASS Training Modules
- RMF Fundamentals Course

---

## ⚠️ Usage Disclaimer

**These examples are for educational purposes.**

- Always verify against current STIG requirements
- Customize for your specific environment
- Obtain ISSM approval for your implementations
- Don't copy without understanding
- Examples may not match your exact scenario

**Your mileage may vary. Use professional judgment.**

---

**Last Updated:** January 2026  
**Status:** Examples coming soon - check back regularly  
**Contributions:** Welcome via pull request  
**Questions:** Open an issue in the repository
