# Current State Architecture

**Status:** To be created in Phase 1

## What to create

Using Draw.io (app.diagrams.net), create a current state architecture diagram showing:

### Required elements
- [ ] 2 data centres (Equinix LD4, Canary Wharf colo)
- [ ] 120 servers grouped by function (Web, App, DB, Middleware)
- [ ] Network connectivity (MPLS, internet, leased lines)
- [ ] Existing AWS account (single account, POC state)
- [ ] Key applications (payments, trading, core banking, reporting)
- [ ] External connections (Bloomberg, SWIFT, FCA reporting)

### File naming
Save as: `current-state.drawio` in this directory

### Tips
- Use AWS architecture icons from Draw.io shape library
- Use on-premises icons for data centre components
- Colour code: blue = network, orange = compute, green = data, red = risk/gap
- Mark the 17 applications without DR in red

### Evidence for submission
Export as PNG and commit both `.drawio` and `.png` files
