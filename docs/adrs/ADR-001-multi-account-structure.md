# ADR-001: Multi-Account AWS Organisation Structure

**Date:** 2024-09-15
**Status:** Proposed
**Deciders:** Sarah Nkemdirim (CTO), [Your Name] (Senior AWS Solutions Architect)
**Tags:** governance · multi-account · landing-zone

---

## Context and Problem Statement

Parlington Ltd operates all workloads in a single AWS account inherited from a 2019 proof-of-concept.
This creates blast radius risk, makes cost allocation impossible, and fails FCA requirements for
environment segregation.

---

## Decision Drivers

- FCA PS21/3: segregation of production from non-production
- ISO 27001 A.12.1.4: Separation of dev, test, and operational environments
- CFO requirement: per-business-unit cost visibility
- NCSC Cloud Security Principle 3: Separation between users

---

## Considered Options

1. Single account with tag-based separation
2. Multi-account with manual structure
3. AWS Organizations + Control Tower

---

## Decision Outcome

**Chosen option:** Option 3 — AWS Organizations + Control Tower

**Rationale:**
> TODO: Complete this section in Phase 2

---

## Proposed Account Structure

```
ROOT (Management Account)
├── Security OU
│   ├── Audit Account
│   └── Log Archive Account
├── Infrastructure OU
│   └── Shared Services Account
├── Workloads OU
│   ├── Production OU
│   │   ├── Payments-Prod
│   │   ├── Trading-Prod
│   │   └── Core-Banking-Prod
│   ├── NonProd OU
│   │   ├── Dev Account
│   │   └── Test Account
│   └── Sandbox OU
└── [TBC] Data Platform OU
```

> ⚠️ TODO: Validate with David Osei (Head of Infrastructure)
> ⚠️ TODO: Confirm OU boundaries with Priya Anand (CRO)

---

## Compliance Notes

- FCA PS21/3: environment segregation supports impact tolerance mapping
- ISO 27001 A.12.1.4: Satisfied by OU-level separation with SCPs

---

## Links

- [AWS Control Tower docs](https://docs.aws.amazon.com/controltower/latest/userguide/what-is-control-tower.html)
- ADR-002: Landing Zone Network Design (to be created in Phase 3)
