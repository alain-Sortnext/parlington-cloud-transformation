# Parlington Ltd — Risk Register
**Status:** DRAFT — Candidate to complete in Phase 3
**Owner:** Senior AWS Solutions Architect
**Review cadence:** Weekly (steering committee)

---

## Risk Matrix

| ID | Category | Risk Description | Likelihood | Impact | RAG | Mitigation | Owner |
|----|----------|-----------------|------------|--------|-----|------------|-------|
| R001 | Regulatory | 17 apps without DR — FCA PS21/3 breach already overdue 14 months | High | Critical | 🔴 RED | DR architecture Phase 8 — prioritise top 5 apps in Phase 3 | CRO |
| R002 | Financial | Cloud spend exceeds £2.4M budget if migration scope creeps | Medium | High | 🟡 AMBER | FinOps framework Phase 8 — Cost Explorer guardrails | CFO |
| R003 | Technical | Legacy app dependencies not fully mapped — hidden coupling risk | High | High | 🔴 RED | Full dependency mapping in Phase 1 discovery | Lead Architect |
| R004 | Security | Existing AWS account has no SCPs — any IAM user has full access | High | Critical | 🔴 RED | Landing Zone + SCPs in Phase 2 | Security Architect |
| R005 | Delivery | CTO mandate: 18 months or regulatory enforcement. Timeline is tight. | Medium | Critical | 🟡 AMBER | Phased delivery plan — MVP by month 9 | CTO |
| R006 | [TBC] | | | | | | |
| R007 | [TBC] | | | | | | |

---

## Notes

> Candidate: You must populate this register with findings from your Phase 1 discovery.
> R006 onwards should be identified from the application portfolio and infrastructure data.
> Each risk must have a mitigation strategy tied to a specific phase deliverable.

---

*Document incomplete — candidate to complete risks R006+ from Phase 1 findings*
