# Target State Architecture

**Status:** To be created in Phase 2

## What to create

Using Draw.io, create the target AWS architecture showing:

### High Level Design (HLD) — Phase 2
- [ ] Multi-account AWS Organisation structure (6+ accounts)
- [ ] AWS Control Tower landing zone
- [ ] Shared Services account (Transit Gateway, DNS, tooling)
- [ ] Production workload accounts
- [ ] Security accounts (Audit, Log Archive)
- [ ] Hybrid connectivity (Direct Connect + VPN failover)

### Low Level Design (LLD) — Phase 2
- [ ] VPC CIDR allocations per account
- [ ] Subnet layout (public, private, data, TGW attach)
- [ ] Security group strategy
- [ ] IAM roles and permission boundaries
- [ ] KMS key hierarchy
- [ ] Transit Gateway routing table

### File naming
- `hld-aws-landing-zone.drawio` — High Level Design
- `lld-network-design.drawio` — Low Level Design
- `lld-security-design.drawio` — Security LLD
