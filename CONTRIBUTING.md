# Contributing to the Parlington Simulation

## Branch strategy

```
main          — your stable evidence base (what gets marked)
feature/phaseN — your working branch for each phase
```

## Workflow

1. Create a branch: `git checkout -b feature/phase-1-discovery`
2. Do your work, commit regularly with descriptive messages
3. Push to GitHub: `git push origin feature/phase-1-discovery`
4. Open a PR to `main` when the phase is complete
5. Merge to `main` — the submission URL you paste into Project Lab should be from `main`

## Commit message format

```
feat(phase-1): add discovery report with application portfolio
fix(terraform): correct VPC CIDR to 10.0.0.0/16
docs(adrs): add ADR-002 landing zone network design
```

## What NOT to commit

- AWS credentials or access keys
- `.tfstate` files (use remote state)
- Passwords or API tokens
- Large binary files (use links to S3 instead)

## Evidence quality

Each commit should represent real work. Screenshots must show:
- Your name / account ID visible where possible
- The specific resource or output being evidenced
- A timestamp or date visible in the console
