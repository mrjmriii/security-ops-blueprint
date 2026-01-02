# Telemetry Agent Operations (Blueprint)

## Purpose
- Provide sanitized scaffolding for agent install/enrollment and grouping.
- Preserve telemetry coverage by keeping endpoint classes mapped to groups.

## Preconditions
- Telemetry manager reachable from endpoint subnets on enrollment ports.
- `telemetry_manager_host` and `telemetry_registration_token` set in inventory/vars.
- Group model updated in `data/telemetry/groups.yml`.
- Template available at `ansible/templates/telemetry/agent-conf.j2`.

## Steps to run
1) Install + enroll Linux agents:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_agent_install.yml --limit linux_endpoints`
2) Install + enroll Windows agents:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_agent_install.yml --limit windows_endpoints`
3) Create/refresh groups:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_agent_groups.yml --limit siem`
4) Assign agents to groups:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_agent_group_assign.yml --limit siem`
5) Rotate API credentials (optional):
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_agent_api_password_rotate.yml --limit siem`

## Expected signals/telemetry
- Enrollment requests in telemetry manager logs.
- Agent services running on endpoints with recent keepalive/heartbeat.
- Per-group configuration rendered and published by the manager.

## Validation checklist
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible -i ansible/inventory/hosts.yml linux_endpoints -m shell -a "systemctl is-active telemetry-agent"`
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible -i ansible/inventory/hosts.yml windows_endpoints -m ansible.windows.win_service -a "name=TelemetrySvc"`
- `curl -s https://<telemetry-manager>/api/agents`
- Confirm per-group config exists in the manager shared config path.

## Rollback
- Uninstall agents: `-e telemetry_agent_state=absent` on `blueprint_agent_install.yml`.
- Remove groups: `-e telemetry_group_state=absent` on `blueprint_agent_groups.yml`.
- Unassign groups: `-e telemetry_group_assign_state=absent` on `blueprint_agent_group_assign.yml`.
