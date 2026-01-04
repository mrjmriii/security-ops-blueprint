# Sprint Plan: Governance + Policy Compliance (2026-01)

## Purpose
Define a focused sprint to harden governance and policy compliance for public-facing outputs and AI-assisted work.

## Preconditions
- Backlog items added and triaged in `docs/backlog.md`.
- Responsible AI exposure response policy exists in `docs/responsible-ai-exposure-policy.md`.
- PM/Builder/Analyst availability confirmed.

## Scope
- Publish classification and sanitize checklist for public releases.
- Public blueprint audit for vendor-specific terms and RFC1918 leakage.
- Pseudotwin sync hardening (pre-publish scans + validation hooks).
- Responsible AI exposure response policy enforcement steps.

## Out of scope
- New feature automation unrelated to governance/policy compliance.
- Infrastructure changes not tied to compliance controls.

## Milestones
- M1 Kickoff + backlog grooming (Day 1)
- M2 Compliance artifacts drafted (Days 2-3)
- M3 Validation hooks implemented (Days 4-5)
- M4 Closeout + review (Day 5)

## Work items (Backlog)
- BL-019: Governance compliance sprint kickoff + milestones
- BL-020: Publish classification + sanitize checklist
- BL-021: Public blueprint audit for vendor-specific terms and RFC1918
- BL-022: Pseudotwin sync hardening with pre-publish scans
- BL-023: Responsible AI exposure response policy enforcement

## Agent assignments
- PM: kickoff, scope lock, milestone tracking, comms in `docs/progress.md`.
- Builder: implement checklist, policy updates, and validation hooks.
- Analyst: run audits, capture logs in `docs/logs/`, confirm remediation.

## Steps to run
1) PM schedules kickoff and confirms scope/milestones.
2) PM updates backlog statuses and assigns owners.
3) Builder drafts artifacts and automation stubs.
4) Analyst validates and documents results.
5) PM closes sprint and records outcomes.

## Validation checklist
- Backlog items move from Ready -> In Progress -> Done with exit criteria met.
- Audit logs exist in `docs/logs/` and are linked in `docs/progress.md`.
- Public blueprint checks show no vendor-specific or RFC1918 leakage.

## Rollback/Revert
- Revert checklist/policy changes if they introduce risk.
- Reopen backlog items if validation fails or scope changes.
