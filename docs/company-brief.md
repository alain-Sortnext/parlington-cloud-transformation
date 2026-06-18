# Parlington Ltd — Company Brief
## Confidential | Cloud Transformation Programme | Senior AWS Solutions Architect

---

## 1. Company Overview

**Parlington Ltd** is a mid-tier UK asset management and institutional services firm headquartered
in Canary Wharf, London. Founded in 1994, the firm manages £4.2 billion in assets under
management (AUM) across four core business lines: UK equities, fixed income, multi-asset
strategies, and institutional custody services.

| Detail | Value |
|--------|-------|
| **Headquarters** | 22 Canada Square, Canary Wharf, London E14 5AB |
| **Founded** | 1994 |
| **Employees** | 1,247 (FTE) |
| **AUM** | £4.2 billion |
| **Revenue (FY2023)** | £87.3 million |
| **EBITDA (FY2023)** | £21.4 million |
| **Regulators** | FCA (FRN: 189442), PRA |
| **Primary cloud region** | eu-west-2 (London) |
| **DR region** | eu-west-1 (Ireland) |

### Business Lines

| Business Line | AUM | Head Count | Key Systems |
|--------------|-----|------------|-------------|
| UK Equities | £1.8bn | 312 | PEMIS (Portfolio Mgmt), Bloomberg Terminal |
| Fixed Income | £1.1bn | 218 | PEMIS, Murex (rates), ICE Data |
| Multi-Asset | £0.9bn | 187 | PEMIS, Aladdin (BlackRock) |
| Institutional Custody | £0.4bn | 156 | SWIFT, FundSettle, Calastone |

---

## 2. The Problem — Why This Programme Exists

### 2.1 FCA Operational Resilience Breach

The FCA's Policy Statement **PS21/3 — Building Operational Resilience** required all regulated
firms to have:

1. Identified their **Important Business Services (IBS)**
2. Set **impact tolerances** for each IBS
3. Mapped and tested the people, processes, technology, and third parties that support each IBS
4. Ensured they could **remain within impact tolerances** by **31 March 2025**

**Parlington is 14 months overdue.** The CRO (Priya Anand) has received two formal letters from
the FCA requesting an updated remediation plan. A third letter would trigger a supervisory review,
which carries the risk of:

- Public censure
- Financial penalty (up to 10% of annual turnover = up to **£8.7 million**)
- Individual accountability action against the CTO and CRO under SMCR

The root cause of non-compliance: **17 of Parlington's 42 applications have no documented
disaster recovery provision.** The applications include the core order management system (OMS),
the client reporting platform, and the regulatory reporting gateway.

### 2.2 Infrastructure Age and Cost

| Metric | Current State | Target State | Gap |
|--------|--------------|--------------|-----|
| Annual infra run-rate | **£3.8M** | **£1.9M** | £1.9M saving required |
| Average server age | 6.4 years | N/A (cloud) | 23 servers EOL in 12 months |
| Data centre contracts | 2 × 5-year terms expiring Q1 2026 | Exit both | Exit deadline: March 2026 |
| DR coverage | 25 of 42 apps | 42 of 42 apps | 17 apps at risk |
| Deployment frequency | Quarterly (manual) | Daily (automated) | — |
| MTTR (major incident) | 4.2 hours average | < 30 minutes | — |

### 2.3 The Failed 2022 Transformation

Parlington attempted an AWS migration in 2022 led by an external systems integrator. The
programme was terminated after 8 months having spent £1.1M with no production workloads
migrated. The board is acutely aware of this failure. The new CTO, Sarah Nkemdirim (joined
January 2024), was specifically hired to fix this.

**What went wrong in 2022 (documented in the post-mortem):**
- No discovery phase — applications were migrated without dependency mapping
- Single AWS account used for all environments — dev broke prod twice
- No IaC — everything deployed via console, no repeatability
- No security architecture — GuardDuty and CloudTrail never enabled
- Programme ran over budget by 40% in month 4, board lost confidence

The candidate must not repeat these mistakes. Every phase of this programme must produce
documented, reproducible, auditable evidence.

---

## 3. The Transformation Programme

### 3.1 Programme Mandate

The board approved the following mandate on **15 January 2024**:

> *"To migrate Parlington Ltd's technology estate to Amazon Web Services within 18 months,
> reducing the annual infrastructure run-rate from £3.8M to £1.9M, achieving full FCA PS21/3
> operational resilience compliance, and establishing a cloud-native delivery capability."*

**Programme budget:** £2.4M (approved, no contingency release without CFO sign-off)
**Programme deadline:** **31 July 2025** (18 months from mandate approval)
**Architecture Review Board date:** **Week 36 (approximately 9 months in)**

### 3.2 Programme Timeline

| Milestone | Target Date | Phase |
|-----------|-------------|-------|
| Discovery complete | Week 4 | Phase 1 |
| Landing Zone live | Week 8 | Phase 2 |
| Network + Security baseline | Week 12 | Phase 3 |
| IaC platform operational | Week 16 | Phase 4 |
| EKS platform live (4 microservices) | Week 22 | Phase 5 |
| CI/CD + Observability operational | Week 26 | Phase 6 |
| Data platform live | Week 30 | Phase 7 |
| Migration Wave 1 complete | Week 34 | Phase 8 |
| **Architecture Review Board** | **Week 36** | **Phase 9** |
| Migration Wave 2 complete | Week 44 | Phase 8 |
| Migration Wave 3 complete | Week 52 | Phase 8 |
| All workloads migrated | Week 70 | Phase 8 |
| Data centre exit | Week 76 | Phase 8 |

### 3.3 Budget Allocation

| Workstream | Budget | Notes |
|------------|--------|-------|
| AWS infrastructure (Year 1) | £680,000 | Incl. Reserved Instances |
| Professional services / architecture | £420,000 | External and internal |
| Tooling and licences | £180,000 | Terraform Cloud, monitoring, security |
| Migration tooling and services | £340,000 | AWS MGN, DMS, partner support |
| Training and enablement | £95,000 | AWS certifications, team upskilling |
| Contingency (8%) | £192,000 | CFO sign-off required to release |
| **Total** | **£2,400,000** | Hard ceiling |

**Target steady-state annual run-rate post-migration: £1,900,000**
(Saving of £1,900,000/year — payback period: 15 months)

---

## 4. Current Technology Estate

### 4.1 Server Inventory Summary

**Total servers: 120**

| Category | Count | Location | Notes |
|----------|-------|----------|-------|
| Web/Application tier | 34 | Equinix LD4 | Mix of Windows 2012R2 and RHEL 7 |
| Database servers | 28 | Equinix LD4 + Canary Wharf | SQL Server 2016, Oracle 12c, PostgreSQL 10 |
| Middleware / ESB | 18 | Canary Wharf colo | IBM MQ, Apache ActiveMQ, MuleSoft |
| Batch / ETL servers | 16 | Equinix LD4 | Custom Python, SSIS |
| Monitoring / tooling | 12 | Both | Nagios, Splunk (on-prem), Jenkins |
| Dev / Test (shared) | 8 | Equinix LD4 | No separation from prod network |
| DR / standby | 4 | Canary Wharf colo | Cold standby, manual failover only |

> ⚠️ NOTE: 8 dev/test servers share the production network — FCA segregation requirement violated

### 4.2 Application Inventory Summary

**Total applications: 42**

| ID | Application | Business Line | Criticality | DR Status | Migration Target |
|----|-------------|--------------|------------|-----------|-----------------|
| APP-001 | PEMIS (Portfolio Management) | All | **P1 — Critical** | ❌ NO DR | Replatform → EKS |
| APP-002 | Order Management System (OMS) | Equities/FI | **P1 — Critical** | ❌ NO DR | Replatform → EKS |
| APP-003 | Client Reporting Platform | All | **P1 — Critical** | ❌ NO DR | Rehost → EC2, then refactor |
| APP-004 | Regulatory Reporting Gateway | Compliance | **P1 — Critical** | ❌ NO DR | Rehost → EC2 |
| APP-005 | Risk Calculation Engine | Multi-Asset | **P1 — Critical** | ✅ Cold standby | Replatform → EKS |
| APP-006 | SWIFT Connectivity (SWIFTNet) | Custody | **P1 — Critical** | ✅ Active-Passive | Retain (SWIFT-managed) |
| APP-007 | FundSettle Integration | Custody | **P2 — High** | ✅ Active-Passive | Retain (vendor-managed) |
| APP-008 | Bloomberg Data Feed | All | **P2 — High** | ✅ Vendor DR | Retain (vendor-managed) |
| APP-009 | Aladdin Integration | Multi-Asset | **P2 — High** | ✅ BlackRock DR | Retain (vendor-managed) |
| APP-010 | Trade Confirmation System | Equities/FI | **P2 — High** | ❌ NO DR | Replatform → EKS |
| APP-011 | Client Portal (web) | All | **P2 — High** | ❌ NO DR | Refactor → CloudFront + S3 + EKS |
| APP-012 | Compliance Monitoring | Compliance | **P2 — High** | ✅ Cold standby | Replatform |
| APP-013 | HR System (Workday) | Corporate | **P3 — Medium** | ✅ Vendor DR | Retain (SaaS) |
| APP-014 | Finance System (Oracle EBS) | Finance | **P2 — High** | ❌ NO DR | Rehost → EC2 |
| APP-015 | Document Management (OpenText) | All | **P3 — Medium** | ✅ Cold standby | Replace → SharePoint Online |
| APP-016 | Email (Exchange on-prem) | Corporate | **P3 — Medium** | ❌ NO DR | Replace → Microsoft 365 |
| APP-017 | Internal Intranet | Corporate | **P4 — Low** | ❌ NO DR | Replace → SharePoint |
| APP-018 | Market Data Platform | All | **P1 — Critical** | ✅ Active-Passive | Replatform |
| APP-019 | Performance Attribution | All | **P2 — High** | ❌ NO DR | Replatform → EKS |
| APP-020 | Custody Reconciliation | Custody | **P2 — High** | ✅ Cold standby | Replatform |
| APP-021–042 | [21 further applications] | Various | P2–P4 | Mixed | TBC in Phase 1 |

> ⚠️ The 17 applications marked ❌ NO DR are the FCA PS21/3 compliance breach.
> The candidate must prioritise these in the DR architecture (Phase 8).
> APP-001 through APP-004 are the most urgent — they are P1 Critical with no DR at all.

### 4.3 Database Estate

| Database | Version | Size | Applications | Migration Path |
|----------|---------|------|-------------|----------------|
| Microsoft SQL Server 2016 | 2016 | 4.2 TB | PEMIS, OMS, Reporting | → Aurora PostgreSQL (DMS) |
| Oracle 12c | 12.1 | 1.8 TB | Risk Engine, Finance (EBS) | → Aurora PostgreSQL (SCT + DMS) |
| PostgreSQL 10 | 10.x | 0.9 TB | Client Portal, Compliance | → Aurora PostgreSQL 15 (DMS) |
| IBM DB2 | 11.5 | 0.3 TB | Legacy batch system | → Retire or replace |
| Redis (on-prem) | 4.0 | Cache only | OMS session cache | → ElastiCache Redis |
| MongoDB | 3.6 | 0.2 TB | Document store (internal) | → DocumentDB |

> ⚠️ SQL Server 2016 is End of Extended Support — Microsoft support ended Oct 2026.
> Oracle 12c licence costs £340,000/year — migration to Aurora saves significant cost.

### 4.4 Network Estate

| Component | Details | Notes |
|-----------|---------|-------|
| Primary data centre | Equinix LD4, Slough | 2 × 10Gbps uplinks |
| Secondary data centre | Canary Wharf colo (shared building) | 2 × 1Gbps uplinks |
| DC interconnect | 10Gbps private MPLS | BT Wholesale |
| Internet connectivity | 2 × 1Gbps (diverse providers) | Redundant |
| AWS connectivity | **NONE currently** | Must implement Direct Connect |
| IP address space | 10.0.0.0/8 (internal) | Fragmented, poor documentation |
| Firewall | Palo Alto PA-5250 (x2, HA) | 3 years old, licence renewal due |
| Load balancers | F5 BIG-IP (x2) | Licences expiring Q3 2025 |

> ⚠️ No AWS Direct Connect exists. Traffic currently goes over public internet to the existing
> POC AWS account. This is a PCI-DSS and FCA security violation for production workloads.

---

## 5. Regulatory and Compliance Context

### 5.1 FCA Requirements

| Requirement | Source | Status | Deadline |
|------------|--------|--------|----------|
| Operational resilience — IBS mapping | PS21/3 | ❌ OVERDUE | Was March 2025 |
| Impact tolerance setting | PS21/3 | ❌ OVERDUE | Was March 2025 |
| Operational resilience testing | PS21/3 | ❌ NOT STARTED | December 2025 |
| Cloud outsourcing notification | SS2/21 | ✅ COMPLETE | Filed March 2024 |
| DORA alignment (EU operations) | DORA 2025 | 🟡 IN PROGRESS | January 2025 |
| Cyber resilience baseline | CBEST | 🟡 IN PROGRESS | Ongoing |

### 5.2 Data Classification Policy

All data processed by Parlington's cloud systems must be classified:

| Classification | Definition | AWS Storage Requirements |
|--------------|------------|-------------------------|
| **RESTRICTED** | Client PII, AUM data, trade data | Encrypted at rest (KMS CMK), VPC only, no internet exposure, audit trail required |
| **CONFIDENTIAL** | Internal financial data, employee data | Encrypted at rest (KMS), VPC only |
| **INTERNAL** | Internal business documents | Encrypted at rest (SSE-S3 minimum) |
| **PUBLIC** | Marketing, job postings | No restriction |

> The candidate must apply data classification tags to all AWS resources:
> `DataClassification: RESTRICTED | CONFIDENTIAL | INTERNAL | PUBLIC`

### 5.3 Relevant Regulatory Frameworks

| Framework | Relevance | Key Requirements for This Programme |
|-----------|-----------|-------------------------------------|
| **FCA PS21/3** | Operational resilience | DR for all P1/P2 apps, impact tolerances documented |
| **FCA SS2/21** | Cloud outsourcing | Material outsourcing register, exit plans, audit rights |
| **PRA SS1/21** | Operational resilience | Overlap with FCA — board-level accountability |
| **UK GDPR** | Data protection | Data residency (eu-west-2 primary), subject access rights, breach notification |
| **ISO 27001** | Information security | Asset management, access control, cryptography, supplier relationships |
| **NCSC Cloud Security Principles** | Cloud security | 14 principles — all must be assessed and documented |
| **AWS Well-Architected Framework** | Architecture quality | Formal WAF review required before ARB sign-off |
| **PCI-DSS v4.0** | Payment card data | Payments service is in-scope — cardholder data must be isolated |
| **DORA (EU)** | Digital operational resilience | Applies to EU client-facing services only |

### 5.4 Glossary of Internal Shorthand

> These codes appear in the operational data files. All team members must know them.

| Code | Meaning |
|------|---------|
| **IBS** | Important Business Service (FCA PS21/3 term) |
| **OMS** | Order Management System (APP-002) |
| **PEMIS** | Portfolio and Execution Management and Information System (APP-001) |
| **RCE** | Risk Calculation Engine (APP-005) |
| **CRP** | Client Reporting Platform (APP-003) |
| **RRG** | Regulatory Reporting Gateway (APP-004) |
| **P1/P2/P3/P4** | Application criticality tier (P1 = most critical) |
| **EOL** | End of Life (server or software past support date) |
| **TGW** | Transit Gateway (AWS networking component) |
| **LZ** | Landing Zone (AWS Control Tower managed multi-account structure) |
| **IaC** | Infrastructure as Code (Terraform, CloudFormation) |
| **DR** | Disaster Recovery |
| **RTO** | Recovery Time Objective (maximum downtime allowed) |
| **RPO** | Recovery Point Objective (maximum data loss allowed) |
| **SCP** | Service Control Policy (AWS Organizations guardrail) |
| **SMCR** | Senior Managers and Certification Regime (FCA accountability) |
| **FinOps** | Financial Operations (cloud cost management discipline) |
| **WAF** | Well-Architected Framework (AWS) OR Web Application Firewall — context dependent |
| **ARB** | Architecture Review Board |
| **IRSA** | IAM Roles for Service Accounts (EKS security pattern) |
| **GitOps** | Git as single source of truth for deployments (ArgoCD) |
| **MTTD** | Mean Time to Detect (incident metric) |
| **MTTR** | Mean Time to Recover (incident metric) |
| **SLI** | Service Level Indicator (measurable metric) |
| **SLO** | Service Level Objective (target for an SLI) |

---

## 6. People — The Programme Team

### 6.1 Parlington Internal Team

| Name | Title | Role in Programme | Key Concern |
|------|-------|------------------|-------------|
| **Sarah Nkemdirim** | Chief Technology Officer | Programme Sponsor, ARB Chair | Delivery timeline, board confidence |
| **Marcus Webb** | Chief Financial Officer | Budget authority | Cost model, £2.4M ceiling, monthly burn |
| **Priya Anand** | Chief Risk Officer | Risk + compliance sign-off | FCA breach, SMCR personal liability |
| **David Osei** | Head of Infrastructure | Technical delivery lead | Server migrations, team upskilling |
| **Rachel Thornton** | Head of Development | Application workstream lead | Developer experience, CI/CD, EKS |
| **James Liu** | FCA Regulatory Affairs Manager | Compliance liaison | FCA correspondence, audit evidence |
| **Amara Diallo** | Head of Data & Analytics | Data platform workstream | Data governance, Lake Formation |
| **Ben Hartley** | Lead Infrastructure Engineer | Day-to-day technical contact | Terraform, Kubernetes, operations |

### 6.2 Your Role

You are the **Senior AWS Solutions Architect** — the most senior technical hire on this programme.
You report directly to Sarah Nkemdirim (CTO) and are accountable to the Architecture Review Board.

**Your responsibilities:**
- All AWS architecture decisions across all 9 phases
- Architecture documentation (HLD, LLD, ADRs)
- Technical governance and standards
- Architecture Review Board presentation (Phase 9)
- Mentoring Ben Hartley (Lead Infrastructure Engineer)
- Sign-off on all Terraform modules before production deployment
- FCA compliance evidence for all architectural decisions

### 6.3 Stakeholder Tensions (Read Carefully)

> These tensions exist in the real programme. You will encounter them in inbox messages.

**Sarah (CTO) vs Marcus (CFO):**
Sarah wants to build the right architecture even if it takes longer. Marcus wants to cut scope
to hit the budget. When they conflict, you are expected to provide the data to resolve the argument.

**Marcus (CFO) vs Priya (CRO):**
Marcus wants to defer the DR work to Phase 8 (it's expensive). Priya insists it must start in
Phase 3 because the FCA letter is already overdue. You will be asked to adjudicate.

**Rachel (Dev) vs David (Infra):**
Rachel wants developer self-service EKS namespaces and GitOps. David wants central control of
all infrastructure changes. You must design a platform that satisfies both — with guardrails.

**Ben Hartley (Lead Eng) vs External Consultant pressure:**
Ben has strong opinions on Terraform module design. He will push back on patterns he disagrees
with. His feedback is usually technically sound. Engage him early.

---

## 7. AWS Environment

### 7.1 Current AWS State (Inherited)

| Account | ID | Purpose | Problems |
|---------|-----|---------|---------|
| parlington-legacy-poc | 483920174651 | Everything (POC from 2019) | No SCPs, root MFA off, public S3 buckets, no CloudTrail |

> ⚠️ This account must NOT be used for production workloads.
> It will be enrolled into the new Landing Zone as a Legacy account.

### 7.2 Target AWS Account Structure

> To be designed in Phase 2. Refer to ADR-001 for the draft structure.

### 7.3 AWS Region Strategy

| Region | Purpose | Rationale |
|--------|---------|-----------|
| **eu-west-2 (London)** | Primary | UK data residency for UK GDPR, lowest latency to Canary Wharf |
| **eu-west-1 (Ireland)** | DR | FCA PS21/3 geographic separation requirement |

> All production workloads must reside in eu-west-2 as primary.
> Data replication to eu-west-1 is required for all P1 and P2 applications.
> No data may be stored outside the EU without explicit DPO and FCA approval.

---

## 8. Key Metrics — Answer Key for Architecture Decisions

> These are the locked figures that drive architectural requirements.
> Every architecture decision must be traceable back to one or more of these metrics.

| Metric | Value | Source | Architecture Implication |
|--------|-------|--------|------------------------|
| Total servers | **120** | Estate audit | Migration wave sizing |
| Total applications | **42** | Application portfolio | Phased migration plan |
| Apps without DR | **17** | Compliance audit | DR architecture priority |
| P1 Critical apps | **6** | Portfolio assessment | First migration wave |
| Current run-rate | **£3.8M/year** | Finance (Marcus Webb) | FinOps target baseline |
| Target run-rate | **£1.9M/year** | Board mandate | 50% cost reduction required |
| Programme budget | **£2.4M** | Board approval | Hard ceiling |
| Oracle licence saving | **£340,000/year** | Oracle contract | Aurora migration ROI |
| FCA penalty risk | **Up to £8.7M** | FCA PS21/3 (10% revenue) | DR programme urgency |
| Failed 2022 spend | **£1.1M** | Post-mortem | Board confidence risk |
| Data centre exit | **March 2026** | DC contracts | Migration deadline |
| ARB date | **Week 36** | Programme plan | Phase 9 hard deadline |
| SQL Server DB size | **4.2 TB** | DBA assessment | Migration complexity / DMS sizing |
| Oracle DB size | **1.8 TB** | DBA assessment | SCT + DMS conversion effort |
| MTTR current | **4.2 hours** | Ops team | Observability target: < 30 min |
| Deployment frequency | **Quarterly** | DevOps assessment | CI/CD target: daily |

---

## 9. Important Business Services (FCA PS21/3)

The following are Parlington's identified Important Business Services under FCA PS21/3.
Impact tolerances must be set for each. The cloud architecture must support these tolerances.

| IBS | Description | Impact Tolerance (RTO) | Impact Tolerance (RPO) | Current Status |
|-----|-------------|----------------------|----------------------|----------------|
| **IBS-001** | Trade execution and order management | 4 hours | 1 hour | ❌ NOT MET — OMS has no DR |
| **IBS-002** | Client portfolio reporting | 24 hours | 4 hours | ❌ NOT MET — CRP has no DR |
| **IBS-003** | Regulatory reporting submission | 4 hours | 2 hours | ❌ NOT MET — RRG has no DR |
| **IBS-004** | Risk calculation and monitoring | 8 hours | 2 hours | 🟡 PARTIAL — cold standby only |
| **IBS-005** | Client portal access | 24 hours | 24 hours | ❌ NOT MET — no DR |
| **IBS-006** | SWIFT connectivity | 2 hours | 30 minutes | ✅ MET — vendor-managed |

---

*This document is the authoritative reference for the Parlington cloud transformation programme.*
*All architecture decisions must be traceable to this brief.*
*Version 1.0 | Programme Initiation | January 2024*
