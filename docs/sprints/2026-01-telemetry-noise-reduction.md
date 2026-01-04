# Sprint Plan: Telemetry Noise Reduction (2026-01)

## Purpose
Reduce alert noise in the public blueprint while preserving detection coverage and auditability.

## Preconditions
- Backlog items BL-024 through BL-028 exist in `docs/backlog.md`.
- Agent group model is defined in `data/telemetry/groups.yml`.
- Group override rendering uses `ansible/templates/telemetry/agent-conf.j2`.
- Responsible AI exposure response policy exists in `docs/responsible-ai-exposure-policy.md`.

## Scope
- Rule tuning for top noisy telemetry alerts on `soc`, `infra`, and `workstations` groups.
- Group-scoped overrides only (no global suppressions).
- Validation evidence with log test utilities for each change.

## Out of scope
- Disabling alerting globally or lowering detection coverage for real environments.
- Vendor-specific implementations or configurations.

## Milestones
- M1 Baseline noisy rule inventory and per-group impact (Day 1)
- M2 Rule override proposals + MITRE mapping (Days 2-3)
- M3 Implement overrides + update docs (Days 4-5)
- M4 Validation and closeout (Day 5)

## Work items (Backlog)
- BL-024: Noisy web gateway 4xx/5xx alerts on `soc`
- BL-025: Promiscuous mode alerts on `soc`
- BL-026: Access-control denial noise on `infra` + `workstations`
- BL-027: Auth success noise on `infra`
- BL-028: File integrity change noise on `infra` + `soc`

## Agent assignments
- PM: kickoff, scope lock, milestone tracking, comms in `docs/progress.md`.
- Builder: implement group-scoped overrides and update docs.
- Analyst: validate with log tests, capture evidence in `docs/logs/`.

## Expected signals/telemetry
- 4xx noise reduced while repeated 4xx spikes still alert (MITRE T1190).
- Promiscuous mode alerts reduced for approved interfaces; new/unapproved interfaces still alert (MITRE T1040).
- Access-control denials reduced for known benign processes; defense impairment attempts still alert (MITRE T1562).
- Auth success alerts reduced while anomalous login bursts still alert (MITRE T1078).
- File integrity noise reduced for expected paths; critical file changes still alert (MITRE T1565).

## Steps to run
1) PM confirms scope and assigns owners.
2) Builder drafts group-scoped overrides and updates docs.
3) Analyst runs log tests for each change and stores logs.
4) PM closes sprint and records outcomes.

## Validation checklist
- Log test utilities run for each adjusted rule with evidence saved in `docs/logs/`.
- Backlog items move to Done with exit criteria met.
- Group overrides documented in `data/telemetry/groups.yml`.

## Rollback/Revert
- Remove the override from `data/telemetry/groups.yml`.
- Re-apply telemetry group configuration (`ansible-playbook ansible/playbooks/blueprint_agent_groups.yml --limit siem`).
