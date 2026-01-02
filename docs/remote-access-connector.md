# Remote Access Connector (Blueprint)

## Purpose
- Provide a sanitized runbook for deploying a remote access connector near lab resources.
- Keep inbound access closed while enabling outbound-only connector traffic.

## Preconditions
- Hypervisor host available for a lightweight VM or container.
- Outbound connectivity permitted to the connector service endpoints.
- Connector tokens stored in secure vars (vault or local secrets store).

## Steps to run
1) Deploy the connector:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_remote_access_connector.yml --limit hypervisor`
2) Validate routing rules and resource access from the connector host.

## Expected signals/telemetry
- Connector status shows "connected" in the remote access admin console.
- Connector service active on the host.
- Lab resources reachable through the connector path.

## Validation checklist
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible -i ansible/inventory/hosts.yml hypervisor -m shell -a "systemctl is-active remote-access-connector"`
- Confirm the connector shows healthy in the admin portal.
- Test a resource URL via the remote access client.

## Rollback
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_remote_access_connector.yml --limit hypervisor -e connector_state=absent`
- Remove the connector VM/container from the hypervisor if created.
