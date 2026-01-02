# Pseudotwin Map

## Purpose
- Define the sanitized blueprint counterparts for internal homelab capabilities.
- Provide a checklist for keeping both repos aligned without leaking sensitive data.

## Capability Map (sanitized)
| Capability | Blueprint artifacts | Notes |
| --- | --- | --- |
| Telemetry agent enrollment | `ansible/playbooks/blueprint_agent_install.yml`, `docs/telemetry-agent-operations.md` | Linux + Windows coverage. |
| Telemetry agent groups | `ansible/playbooks/blueprint_agent_groups.yml`, `ansible/playbooks/blueprint_agent_group_assign.yml`, `data/telemetry/groups.yml` | Groups + per-group config. |
| API credential rotation | `ansible/playbooks/blueprint_agent_api_password_rotate.yml` | Update downstream integrations. |
| SOC integrations | `ansible/playbooks/blueprint_soc_integrations.yml`, `docs/soc-integrations.md` | Case/analysis/intel/automation wiring. |
| Remote access connector | `ansible/playbooks/blueprint_remote_access_connector.yml`, `docs/remote-access-connector.md` | Outbound-only connector. |
| Edge IDS/IPS | `ansible/playbooks/blueprint_edge_ids.yml`, `docs/edge-ids-ips.md` | Alert flow to SIEM. |
| Edge DNS filtering | `ansible/playbooks/blueprint_edge_dns_filter.yml`, `docs/edge-dns-filter.md` | Blocklist enforcement. |
| Windows remote management | `ansible/playbooks/blueprint_windows_remote_mgmt_tls.yml`, `docs/windows-remote-management.md` | TLS hardening. |
| Social-engineering postures | `docs/social-engineering-postures.md`, `ansible/postures/social_engineering/` | Lab-only posture drift tests. |
| Power profiles | `ansible/playbooks/blueprint_power_profiles.yml`, `docs/power-policy.md` | Safe lab power modes. |
| Validation checks | `scripts/validate-blueprint.sh`, `docs/validation-playlist.md` | DNS/TLS/HTTP spot checks. |

## Alignment checklist
- Update `data/sanitization-map.tsv` when new internal entrypoints appear.
- Mirror new runbooks with sanitized docs under `docs/`.
- Add placeholder playbooks for new automation entrypoints.
- Run `scripts/sanitize-blueprint.sh` before publishing.
