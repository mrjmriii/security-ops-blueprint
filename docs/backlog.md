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
