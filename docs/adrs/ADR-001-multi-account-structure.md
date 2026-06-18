# ADR-001: Multi-Account AWS Organisation Structure

**Date:** 2024-09-15
**Status:** Proposed
**Deciders:** Sarah Nkemdirim (CTO), [Your Name] (Senior AWS Solutions Architect)
**Tags:** governance · multi-account · landing-zone

---

## Context and Problem Statement

Parlington Ltd currently operates all workloads in a single AWS account inherited from a 2019
proof-of-concept. This creates blast radius risk, makes cost allocation impossible, and fails
FCA requirements for environment segregation. A multi-account structure is required as the
foundation of the cloud transformation programme.

---

## Decision Drivers

- FCA PS21/3: segregation of production from non-production environments
- ISO 27001 Annex A.12: separation of development, test, and operational environments
- Cost transparency: Marcus Webb (CFO) requires per-business-unit cost visibility
- Security: blast radius containment in event of account compromise
- NCSC Cloud Security Principle 3: separation between users

---

## Considered Options

1. **Single account with tag-based separation** — use resource tags to separate environments
2. **Multi-account with manual structure** — create accounts manually, manage via IAM
3. **AWS Organizations + Control Tower** — managed landing zone with guardrails and SCPs

---

## Decision Outcome

**Chosen option:** Option 3 — AWS Organizations + Control Tower

**Rationale:**
> TODO: Complete this section — what are the specific reasons Control Tower was chosen?
> Consider: automated guardrails, account vending, FCA compliance alignment, operational overhead

---

## Proposed Account Structure

```
ROOT (Management Account)
├── Security OU
│   ├── Audit Account
│   └── Log Archive Account
├── Infrastructure OU
│   └── Shared Services Account (Transit Gateway, DNS, tooling)
├── Workloads OU
│   ├── Production OU
│   │   ├── Payments-Prod
│   │   ├── Trading-Prod
│   │   └── Core-Banking-Prod
│   ├── NonProd OU
│   │   ├── Dev Account
│   │   └── Test Account
│   └── Sandbox OU
│       └── Innovation Account
└── [TBC] — Data Platform OU?
```

> ⚠️ TODO: Validate account structure with David Osei (Head of Infrastructure)
> ⚠️ TODO: Confirm OU boundaries with Priya Anand (CRO) for compliance segregation

---

## Consequences

### Positive
- FCA-compliant environment segregation from day one
- Centralised logging and audit trail (required by Priya Anand, CRO)

### Negative / Trade-offs
- Control Tower has limitations with existing accounts — migration complexity TBC
- Account vending process needs definition before onboarding teams

---

## Compliance Notes

- FCA PS21/3 Operational Resilience: environment segregation supports impact tolerance mapping
- ISO 27001 A.12.1.4: Separation of development, testing and operational environments
- NCSC Cloud Security Principle 3: Satisfied by OU-level separation with SCPs

---

## Links

- [AWS Control Tower documentation](https://docs.aws.amazon.com/controltower/latest/userguide/what-is-control-tower.html)
- [AWS Organizations SCP reference](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html)
- ADR-002: Landing Zone Network Design (to be created in Phase 3)
