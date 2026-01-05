# Backlog (Sanitized)

## Purpose
Single backlog for blueprint work, prioritized by the Eisenhower matrix and
mapped to the delivery model in `docs/project-planning.md`.

## Status Legend
- Ready
- In Progress
- Blocked
- Done

## Current Backlog
| ID | Item | Eisenhower | Delivery | Status | Exit Criteria |
| --- | --- | --- | --- | --- | --- |
| BL-001 | Enforce least-privilege service keys for alert routing | Important | Waterfall | Ready | Service keys scoped to alert creation; admin keys removed from runtime. |
| BL-002 | Validate end-to-end signal flow (SIEM -> case -> analysis -> intel) | Urgent + Important | Agile | Ready | Test alert creates a case; analysis completes; intel lookup succeeds. |
| BL-003 | Define IPv6 posture (disabled until policy approves) | Important | Waterfall | Ready | IPv6 state documented with rollback steps. |
| BL-004 | Tune DNS filtering allowlist for critical SaaS | Important | Agile | Ready | Essential services resolve without manual overrides. |
| BL-005 | Syslog ingestion baseline (firewall -> SIEM) | Important | Waterfall | Ready | Logs arrive and parse with alerts or archives. |
| BL-006 | Telemetry agent coverage baseline | Important | Kanban | Ready | All in-scope endpoints enrolled and grouped. |
| BL-007 | Mailbox alerting validation for high-severity signals | Important | Agile | Ready | Alerts arrive in mailbox and are filtered. |
| BL-008 | Automate pseudotwin sanitization + sync | Important | Waterfall | Ready | Sanitizer run updates public blueprint safely. |
| BL-009 | Add weekly integration smoke test | Important | Agile | Ready | Single command validates core integrations. |
| BL-010 | Document API key rotation cadence | Important | Kanban | Ready | Rotation steps + schedule documented. |
| BL-011 | Add project governance scaffolds (RACI, SWOT, PESTLE, compliance) | Important | Waterfall | Done | Planning templates published in docs. |
| BL-012 | Add agent ops model + token budget tracking | Important | Waterfall | Done | Agent model, budget plan, and request log published. |
| BL-013 | Add weekly token guardrail for low-budget cycles | Important | Waterfall | Done | Weekly guardrail + checkpoint table documented. |
| BL-014 | Add vision + agent persona configs | Important | Waterfall | Done | Vision doc and agent configs published and linked. |
| BL-015 | Harmonize documentation with standards + terminology | Important | Waterfall | Done | Standards + terminology docs published; key plans aligned to Purpose. |
| BL-016 | Normalize runbooks to doc lint checklist | Important | Waterfall | Done | Runbooks aligned to required sections and checklist added. |
| BL-017 | Normalize plan docs with dependencies/risks/validation | Important | Waterfall | Done | Plan docs updated to include dependencies, risks, and validation guidance. |
| BL-018 | Add doc lint script for runbooks + plans | Important | Waterfall | Done | `scripts/validate-docs.sh` enforces headings. |
| BL-024 | Telemetry: reduce noisy web gateway 4xx/5xx alerts on `soc` group | Important | Agile | Ready | Group-scoped overrides documented in `docs/telemetry-agent-operations.md` + `data/telemetry/groups.yml`; log test utility evidence captured; 5xx spikes and repeated 4xx per source still alert (MITRE T1190). |
| BL-025 | Telemetry: tune promiscuous mode alerts on `soc` group | Important | Agile | Ready | Rule tuning scoped to `soc`; verification logs show unauthorized promisc still alerts (MITRE T1040). |
| BL-026 | Telemetry: reduce access-control deny noise on `infra` + `workstations` | Important | Agile | Ready | Group-scoped allowlists documented; alerting preserved for defense impairment attempts (MITRE T1562); validation logs captured. |
| BL-027 | Telemetry: reduce auth success noise on `infra` | Important | Agile | Ready | Frequency/threshold tuning documented; anomalous login bursts still alert (MITRE T1078); validation logs captured. |
| BL-028 | Telemetry: tune file integrity change noise on `infra` + `soc` | Important | Agile | Ready | FIM exclusions documented; critical file changes still alert (MITRE T1565); validation logs captured. |
| BL-029 | Add DNS high availability + redundancy (multiple resolvers, failover validation) | Important | Waterfall | Ready | Secondary resolver deployed; clients use multiple resolvers; failover test passes; docs updated. |
| BL-019 | Governance compliance sprint kickoff + milestones | Important | Waterfall | Ready | Sprint plan published; kickoff scheduled; milestones confirmed. |
| BL-020 | Publish classification + sanitize checklist | Important | Waterfall | Ready | Checklist published; public release steps documented. |
| BL-021 | Public blueprint audit for vendor-specific terms and RFC1918 | Important | Agile | Ready | Audit log saved; findings remediated or accepted with rationale. |
| BL-022 | Pseudotwin sync hardening with pre-publish scans | Important | Waterfall | Ready | Pre-publish scans documented and runnable; gates added to sync workflow. |
| BL-023 | Responsible AI exposure response policy enforcement | Important | Waterfall | Ready | Enforcement steps documented; audit evidence captured. |
