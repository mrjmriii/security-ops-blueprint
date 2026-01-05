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
| BL-030 | Backup BIA + RTO/RPO/MTD definitions | Important | Waterfall | Ready | BIA doc captures critical assets, data owners, RTO/RPO/MTD, and risk tolerance. |
| BL-031 | Backup verification + restore drill | Important | Agile | Ready | Restore tests executed; evidence logs saved; RPO measured; lessons recorded. |
| BL-032 | Backup integrity + immutability controls | Important | Waterfall | Ready | Verification outputs captured; retention/immutability controls documented; residual risk noted. |
| BL-033 | Business continuity + disaster recovery runbooks | Important | Waterfall | Ready | BCP/DRP docs include roles, comms plan, alternate processing guidance, and test cadence. |
| BL-034 | Backup failure monitoring + alerting | Important | Agile | Ready | Alerts on failed jobs; escalation paths documented; test alert evidence captured. |
| BL-035 | Status endpoint + health rollout | Important | Waterfall | Ready | /status schema defined; services emit health; status view validated; evidence captured. |
| BL-036 | Automated social engineering postures (lab-only) | Important | Waterfall | Ready | Posture automation apply/revert; warnings documented; telemetry captured. |
| BL-037 | Red team lab core buildout (directory services + endpoints) | Important | Waterfall | Ready | Directory services and endpoints operational; lab-only posture toggles documented; validation evidence stored. |
| BL-038 | Recon + footprinting automation | Important | Agile | Ready | OSINT/DNS/web footprint automation; outputs normalized; evidence stored. |
| BL-039 | Active information gathering automation | Important | Agile | Ready | Host/service discovery automation; noise controls; evidence stored. |
| BL-040 | Vulnerability assessment automation | Important | Agile | Ready | Scanner orchestration; result parsing; risk triage captured. |
| BL-041 | Network penetration testing automation | Important | Agile | Ready | Shell infrastructure and pivoting automation; lab-only safeguards; evidence stored. |
| BL-042 | Exploitation automation | Important | Agile | Ready | Service exploit automation; lab-only safeguards; evidence stored. |
| BL-043 | Post-exploitation automation | Important | Agile | Ready | Post-exploitation workflows automated; containment and cleanup steps documented. |
| BL-044 | Directory services attack automation | Important | Agile | Ready | Directory service enumeration and trust abuse automation; detection hooks defined. |
| BL-045 | Advanced directory attacks + detection engineering | Important | Waterfall | Ready | Advanced attack automation; detections mapped and validated. |
| BL-046 | Command and control (C2) automation | Important | Waterfall | Ready | C2 lab framework automated; operator workflows documented. |
| BL-047 | Wireless penetration testing automation | Important | Agile | Ready | Wireless lab tooling automated; RADIUS workflow documented. |
| BL-048 | Advanced wireless penetration testing automation | Important | Agile | Ready | WPA/WPA2/WPA3 and enterprise workflows automated; evidence stored. |
| BL-049 | Wireless security hardening automation | Important | Waterfall | Ready | Wireless hardening controls automated; validation evidence captured. |
| BL-050 | Web application security automation | Important | Agile | Ready | OWASP-aligned testing automation; evidence stored; detections mapped. |
| BL-051 | Make SVG assets dark-mode friendly | Important | Waterfall | Ready | SVG assets render legibly in light and dark modes; color tokens documented; preview checklist added. |
| BL-019 | Governance compliance sprint kickoff + milestones | Important | Waterfall | Ready | Sprint plan published; kickoff scheduled; milestones confirmed. |
| BL-020 | Publish classification + sanitize checklist | Important | Waterfall | Ready | Checklist published; public release steps documented. |
| BL-021 | Public blueprint audit for vendor-specific terms and RFC1918 | Important | Agile | Ready | Audit log saved; findings remediated or accepted with rationale. |
| BL-022 | Pseudotwin sync hardening with pre-publish scans | Important | Waterfall | Ready | Pre-publish scans documented and runnable; gates added to sync workflow. |
| BL-023 | Responsible AI exposure response policy enforcement | Important | Waterfall | Ready | Enforcement steps documented; audit evidence captured. |
