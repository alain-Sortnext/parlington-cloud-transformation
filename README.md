# Parlington Ltd — Enterprise AWS Cloud Transformation

> **Project Lab Simulation | Senior AWS Solutions Architect**

---

## Overview

Parlington Ltd is a UK-based asset management firm (£4.2bn AUM) undergoing a full enterprise cloud
transformation to AWS. This repository is your working environment throughout the simulation.
You will build, fix, and extend the architecture across 9 phases.

**Regulatory context:** FCA · PRA · UK GDPR · ISO 27001 · NCSC Cloud Security Principles · PS21/3

---

## Repository Structure

```
parlington-cloud-transformation/
├── docs/                  # Discovery, ADRs, risk register, stakeholder analysis
├── architecture/          # Draw.io diagrams — current state, target state
├── terraform/             # IaC modules — partially complete
├── cloudformation/        # CFN templates — one is broken
├── networking/            # Network design documents
├── security/              # Security policies and baseline configs
├── kubernetes/            # EKS manifests — incomplete, has deliberate errors
├── gitops/                # ArgoCD application configs
├── ci-cd/                 # GitHub Actions workflows — broken pipeline
├── python/                # Boto3 automation scripts — bugs present
├── data-platform/         # Glue, Athena, Redshift configs
├── migration/             # Migration strategy and wave plans
├── observability/         # Prometheus, Grafana, CloudWatch configs
├── finops/                # Cost analysis and FinOps framework
├── ai/                    # Amazon Bedrock RAG architecture
├── presentations/         # ARB packs and executive presentations
└── submissions/           # Your phase submission evidence goes here
```

---

## Simulation Phases

| Phase | Title | Key Deliverable |
|-------|-------|-----------------|
| 1 | Discovery & Portfolio Analysis | Enterprise Discovery Pack |
| 2 | Target Architecture & Landing Zone | HLD + LLD + Governance Framework |
| 3 | Networking, Security & Hybrid Cloud | Security & Network Architecture |
| 4 | IaC, Automation & Operations | Terraform Platform + Runbook |
| 5 | Platform Engineering, Kubernetes & GitOps | Production EKS + GitOps |
| 6 | DevSecOps, CI/CD & Observability | Delivery Platform + Dashboards |
| 7 | Database Architecture & Data Platform | Enterprise Data Platform |
| 8 | Migration, DR & FinOps | Transformation Programme |
| 9 | Enterprise AI & Architecture Review Board | ARB Pack + Executive Presentation |

---

## Important Notes

- Some files are **intentionally incomplete or broken** — identifying and fixing them is part of the simulation
- All architecture decisions must be documented in `/docs/adrs/`
- All phase evidence goes in `/submissions/phase-N/`

---

*Parlington Ltd is a fictional company created for Project Lab. All data is simulated.*
