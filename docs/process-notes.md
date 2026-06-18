# Parlington Ltd — Infrastructure & Cloud Programme Process Notes
## Handover Document — Outgoing: Craig Whitfield (Lead Infrastructure Architect)
## Incoming: Senior AWS Solutions Architect (YOU)
### Last updated: 14 September 2024 | Status: INCOMPLETE — Craig left on short notice

---

> ⚠️ **IMPORTANT NOTE FROM DAVID OSEI (Head of Infrastructure):**
> Craig Whitfield resigned with 2 weeks notice on 2 September 2024.
> These notes cover what he managed to document before leaving.
> Stages 4 through 9 are NOT documented here.
> You will need to reconstruct the rest from conversations with the team
> and from the data files in /docs/data/.
>
> Key people to talk to immediately:
> - **Ben Hartley** — knows the Terraform state (what little exists)
> - **Amara Diallo** — knows the data estate and DB dependencies
> - **James Liu** — knows the FCA correspondence history (there's more than you've been told)
>
> Good luck. You'll need it.
> — David Osei, 15 September 2024

---

## Stage 1 — Discovery and Estate Assessment

### 1.1 What We Have

The server estate CSV (/docs/data/server-estate.csv) was pulled from our asset management
tool (Nlyte) in August 2024. It is mostly accurate but has some known issues:

- The `server_age_years` column for about 6 servers is recorded in months not years.
  I never got round to fixing this. You'll spot them — they have large numbers.
- `monthly_cost_gbp` is missing for 8 servers. These are the ones on the Canary Wharf
  colo where the billing is consolidated. Ask David Osei for the consolidated invoice.
- The `last_patched` dates are in different formats because three different engineers
  updated the spreadsheet over 18 months. Sorry about that.
- **SRV-047 appears twice** in the export. This is a known Nlyte bug — the server was
  decommissioned and re-provisioned in the same quarter and both records persisted.
  The SECOND record (hostname PAR-DB-047) is the current one. Delete the first.

> CHECK THIS: The `dr_status` column values are inconsistent — "NO DR", "None", "N/A",
> "Not configured" all mean the same thing. There are 17 applications without DR per the
> compliance audit, but if you count the server-estate.csv NO DR variants you will get a
> higher number. This is because multiple servers can host the same application.
> **Use the application-portfolio.csv as the authoritative source for DR status.**

### 1.2 The Application Portfolio

The app portfolio (/docs/data/application-portfolio.csv) was compiled by Rachel Thornton's
team in July 2024. It covers all 42 applications.

Known issues with this file:
- APP-019 (Performance Attribution) appears twice. The second entry with owner "A. Diallo"
  is a draft that was never removed. Use the first entry.
- The `migration_complexity` column has inconsistent formats (7, 7/10, High, Medium-High).
  When you normalise these, you will find that **15 applications score 7 or higher**.
  These are your highest-risk migrations. Do not underestimate APP-001 and APP-002 —
  both score 9 and have no DR. This combination is your biggest programme risk.
- The `dependencies` column uses different delimiters (|, comma, semicolon) depending
  on who entered the row. Normalise before analysis.

> ⚠️ IMPORTANT — HIDDEN DEPENDENCY PATTERN:
> I noticed something when I was building the dependency map that I never wrote up properly.
> Every application with more than 3 dependencies also has a complexity score of 7 or higher.
> I checked this three times. It holds without exception.
> **This means dependency count is your single best predictor of migration risk.**
> I was going to raise this at the programme board but ran out of time.
> You should validate this yourself using the portfolio CSV and raise it with Rachel Thornton.

### 1.3 The Operational Report

The weekly operational data (/docs/data/operational-report.csv) covers 12 weeks
from June to September 2024.

A few things to flag:

- **Week 3 appears twice** — there is a "Week 3 (revised)" entry. Use the revised one.
  The original had the wrong MTTR for the OMS incident.
- **Week 6 total cost looks low** — £50,801 vs the normal ~£56,000/week.
  This is NOT a real saving. The AWS POC account invoice was delayed and the
  £20,800 AWS charge was not included. The notes column on that row explains this.
  **Do not report Week 6 as evidence of cost reduction. It is a billing artefact.**
- **Week 7 DB tier cost is blank** — the DBA team (Amara's group) missed the weekly
  submission. The actual cost for that week was approximately £31,200. You can
  interpolate or leave it blank but flag the gap.
- **Week 9 incident count is TBC** — still being closed off at time of writing.

> BURIED HINT — READ THIS CAREFULLY:
> The most important thing in the operational report is not the incident count.
> It is the tier cost breakdown. Run the numbers: the database tier alone accounts
> for approximately **55% of total infrastructure spend**.
> Windows servers look expensive on the surface (high average cost per server).
> But if you break costs down by TIER not by OS, you will see that database servers
> are expensive regardless of what OS they run. The OS is not the cost driver.
> **The tier is the cost driver. Specifically: database tier.**
> This changes your migration prioritisation. Don't migrate Windows servers first.
> Migrate database tier workloads first — that is where the money is.
> Cross-check: /docs/data/server-estate.csv column `category` = "Database" vs
> `monthly_cost_gbp`. Average is approximately £4,700/server/month.
> Compare to Windows-only average: approximately £2,200/server/month.
> The difference is the tier, not the OS.

### 1.4 Patch Compliance Trend

One thing I am genuinely worried about that I did not raise formally:
patch compliance dropped from ~71% in weeks 1-8 to ~55% in weeks 9-12.

The reason: Ben Hartley's team was asked to support the cloud project onboarding
from week 9 onwards, which pulled them off patching duties. This has not been
formally documented anywhere. Priya Anand (CRO) does not know about this.

> NOT DOCUMENTED FORMALLY. Ben confirmed this verbally to me in our last 1:1.
> You should raise this with David Osei and decide whether to escalate to Priya.
> An unpatched estate during a major transformation is an additional risk vector.
> The FCA will ask about patch posture during any supervisory review.

---

## Stage 2 — AWS Account and Governance Baseline

### 2.1 The Existing AWS Account

Account ID: **483920174651** (parlington-legacy-poc)
Region: eu-west-2 (London)
Root email: aws-root@parlington.co.uk
Root MFA: **NOT ENABLED** ← fix this immediately
CloudTrail: **NOT ENABLED** ← FCA audit trail violation
GuardDuty: **NOT ENABLED**
Public S3 buckets: **3 exist** — names below

Known public S3 buckets (should NOT be public):
- `parlington-poc-data-2019` — contains old test data, unknown classification
- `parlington-reports-staging` — DEPRECATED? contains what look like real report extracts
- `parlington-terraform-state` — **CRITICAL: Terraform state file is PUBLIC**

> ⚠️ CRITICAL SECURITY ISSUE:
> The Terraform state bucket is publicly readable. I discovered this in August 2024.
> The state file contains resource ARNs, account IDs, and some parameter values.
> It does NOT contain credentials (those are in Parameter Store) but it is still
> a significant information disclosure. Block public access on this bucket immediately.
> I raised this with David Osei verbally. It was not actioned. It is still public.
> CHECK THIS — confirm it is still public and remediate as your first action.

### 2.2 IAM State

Current IAM users in the legacy account (should all be converted to SSO):

| User | Access Keys | Last Used | Console Access | MFA |
|------|-------------|-----------|----------------|-----|
| craig.whitfield | Active (2 keys) | 2024-09-01 | Yes | No |
| ben.hartley | Active (1 key) | 2024-09-13 | Yes | No |
| amara.diallo | Active (1 key) | 2024-09-10 | Yes | No |
| parlington-ci | Active (1 key) | 2024-09-14 | No | N/A |
| terraform-deploy | Active (2 keys) | 2024-09-14 | No | N/A |
| admin-breakglass | Active (1 key) | 2024-01-15 | Yes | No |

> ⚠️ PROBLEMS:
> - No IAM users have MFA enabled — FCA and ISO 27001 violation
> - craig.whitfield has 2 active access keys — one was rotated but old one never deleted
> - admin-breakglass last used January 2024 — unknown who used it and why
> - parlington-ci and terraform-deploy have AdministratorAccess policy attached
>   This means the CI pipeline and Terraform have FULL AWS ACCOUNT ACCESS.
>   Should be scoped to least-privilege. Fix in Phase 4.

### 2.3 Landing Zone — NOT STARTED

The AWS Control Tower Landing Zone has not been set up.

ADR-001 (/docs/adrs/ADR-001-multi-account-structure.md) has the draft account structure
but the rationale section is incomplete. You need to finish it in Phase 2.

Key decisions still outstanding:
- [ ] How many OUs? (I suggested 5, Rachel wants to add a Data OU)
- [ ] Which accounts go in which OU?
- [ ] SCP strategy — what do we deny at root vs OU level?
- [ ] Account naming convention — we never agreed one
- [ ] Whether to use Control Tower Account Factory or custom vending

> NOT DOCUMENTED: The email addresses for new AWS accounts need to come from IT.
> David Osei has a block of parlington+aws-XXXX@parlington.co.uk aliases set up.
> Ask him for the full list before you start account provisioning.

---

## Stage 3 — Networking Baseline

### 3.1 Current Network State

The network estate is documented in the company brief (/docs/company-brief.md Section 4.4).

Key things not in the company brief:

- The Palo Alto firewall rules have not been audited in 18 months.
  There are approximately 2,400 firewall rules. Nobody knows what most of them do.
  Ben Hartley has a Panorama export from March 2024 — ask him for it.

- The IP address space (10.0.0.0/8) is very fragmented:
  - 10.0.0.0/16 — Canary Wharf servers
  - 10.1.0.0/16 — Equinix LD4 servers
  - 10.2.0.0/24 — Management / OOB network
  - 10.50.0.0/16 — DEPRECATED? — assigned to 2019 AWS POC, may still be routed
  - 10.100.0.0/16 — DR / standby network
  - 10.200.0.0/16 — Unknown — appeared in routing table 2022, nobody knows what it is

> CHECK THIS — 10.200.0.0/16 is a mystery. Ben thinks it might be from the 2022
> failed transformation — a VPC CIDR that was never cleaned up. Or it might be
> a rogue device on the network. Needs investigation before you design the AWS VPC CIDR plan.
> If 10.0.0.0/16 and 10.1.0.0/16 are both in use, you CANNOT use these for your AWS VPCs
> without creating routing conflicts. Plan accordingly.
> Recommendation: use 172.16.0.0/12 address space for AWS VPCs — no conflict with on-prem.

### 3.2 AWS VPC Design — NOT STARTED

No VPC design has been done. The Terraform module in /terraform/vpc/main.tf was started
by Ben Hartley but has a known bug — the default CIDR is set to 172.16.0.0/16 which
would conflict with the recommendation above. You need to:

1. Agree the CIDR plan with David Osei and Ben Hartley
2. Fix the Terraform module (wrong default CIDR, missing route tables, no flow logs)
3. Design the subnet layout (public, private, data, TGW attachment)
4. Plan for Transit Gateway connectivity to on-prem via Direct Connect

> DEPRECATED? — There is a CloudFormation template in /cloudformation/ that Ben started
> for a VPC but abandoned when we decided to use Terraform. It may still have useful
> reference but the CIDR ranges in it are wrong. Do not use it as-is.

### 3.3 Direct Connect — NOT STARTED

We do not have a Direct Connect connection to AWS. All current AWS traffic goes over
the public internet through the NAT gateway in the legacy POC account.

For production financial services workloads this is unacceptable:
- PCI-DSS requires dedicated connectivity for cardholder data environments
- FCA SS2/21 requires appropriate network controls for material outsourcing
- Latency over public internet is 8-12ms; Direct Connect would give 1-2ms

Recommended approach:
- Primary: 1Gbps Dedicated Direct Connect via Equinix LD4 (we already have a cage there)
- Secondary: 1Gbps Hosted Direct Connect via Colt (for diversity)
- Failover: Site-to-Site VPN as backup to both DX circuits

> NOT DOCUMENTED — I had a conversation with the Equinix account team in July 2024
> about ordering a Direct Connect. Lead time is 8-12 weeks from order to live.
> You need to order this immediately if you want it ready for Phase 3.
> Contact: equinix-account@equinix.com — reference Parlington cage ID PAR-LD4-C12
> EQUINIX NEVER CHASED US FOR A RESPONSE. Order has not been placed.

---

## Open Questions (Unresolved at Handover)

These are the things I did not get answers to before leaving.
Each one is a blocker or risk for a specific phase.

| # | Question | Blocker For | Who To Ask | Urgency |
|---|----------|------------|------------|---------|
| OQ-001 | What is 10.200.0.0/16 and who owns it? | Phase 3 VPC design | Ben Hartley / Network team | HIGH |
| OQ-002 | Has the Equinix Direct Connect order been placed? | Phase 3 hybrid connectivity | David Osei / Equinix | CRITICAL |
| OQ-003 | What are the email aliases for new AWS accounts? | Phase 2 Landing Zone | David Osei | HIGH |
| OQ-004 | Is parlington-reports-staging S3 bucket classified? DPO sign-off needed. | Phase 3 security baseline | James Liu / DPO | CRITICAL |
| OQ-005 | Who used the admin-breakglass IAM user in January 2024? | Phase 2 IAM audit | David Osei / Security team | HIGH |
| OQ-006 | Rachel wants a Data OU in the Landing Zone. Has this been agreed? | Phase 2 OU design | Sarah Nkemdirim | MEDIUM |
| OQ-007 | EBS licence: can we migrate to Aurora without Oracle EBS re-licensing? | Phase 7 DB migration | Marcus Webb / Oracle account mgr | CRITICAL |
| OQ-008 | SWIFT re-certification: if APP-006 moves to AWS, what is the process? | Phase 4/5 migration planning | David Osei / SWIFT relationship mgr | HIGH |
| OQ-009 | Patch compliance drop (weeks 9-12): has this been escalated to CRO? | Immediate | David Osei | HIGH |
| OQ-010 | FCA correspondence: James Liu mentioned a third letter. Has it arrived? | Phase 1 risk assessment | James Liu / Sarah Nkemdirim | CRITICAL |

---

## Contacts (Current as of September 2024)

| Person | Role | Notes |
|--------|------|-------|
| David Osei | Head of Infrastructure | Your closest internal contact. Knows the estate. Direct line: ext 4421 |
| Ben Hartley | Lead Infrastructure Engineer | Knows Terraform state, network routing tables, Jenkins configs |
| Amara Diallo | Head of Data & Analytics | Knows DB estate, Glue jobs, Oracle dependencies |
| Rachel Thornton | Head of Development | Knows app dependencies, CI/CD pipelines, Kubernetes ambitions |
| James Liu | FCA Regulatory Affairs | Knows all FCA correspondence. More cautious than he lets on in meetings. |
| Sarah Nkemdirim | CTO | Programme sponsor. Needs weekly updates. Do not surprise her. |
| Marcus Webb | CFO | Watches the budget weekly. Will push back on any over-run. |
| Priya Anand | CRO | Ask her about the FCA letters. She knows more than she is saying. |

---

## What Is NOT Documented Here (Stages 4–9)

The following have no handover documentation. You are starting from scratch on all of these:

- **Stage 4 — IaC Platform:** The Terraform modules in /terraform/ are 15-20% complete.
  Ben Hartley started them. They have known bugs (see /terraform/vpc/main.tf comments).
  The CloudFormation template in /cloudformation/security-baseline.yaml has a syntax error
  and a logical error. Both are commented in the file.

- **Stage 5 — Kubernetes / EKS / GitOps:** Rachel Thornton has a vision for this.
  The manifests in /kubernetes/ were started by a contractor who left in August 2024.
  They have known errors (wrong container port, missing resource limits, no probes).
  ArgoCD config in /kubernetes/gitops/argocd-app.yaml has placeholder repoURL — not wired up.

- **Stage 6 — CI/CD and Observability:** The GitHub Actions pipeline in
  /.github/workflows/deploy.yml is broken. Known issues are commented in the file.
  Prometheus config in /observability/prometheus.yml is missing all application scrape configs.

- **Stage 7 — Data Platform:** Not started. Amara Diallo has requirements but nothing built.

- **Stage 8 — Migration:** Not started. No migration waves defined. No DR architecture.

- **Stage 9 — AI / ARB:** Not started. Sarah mentioned Bedrock in a board meeting.
  Nobody has scoped this yet.

---

## Final Note from Craig

I'm sorry I couldn't finish this properly. The programme was well behind where it should be
and I ran out of personal bandwidth.

The three things I'd prioritise if I were staying:

1. **Block those public S3 buckets today** — especially the Terraform state one.
2. **Order the Direct Connect now** — 8-12 week lead time will bite you.
3. **Talk to James Liu about the FCA letters** — there is more to this than the
   programme board has been told.

Good luck. The team are good people. They just need direction.

— Craig Whitfield, 14 September 2024
