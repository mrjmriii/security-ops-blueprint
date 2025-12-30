# Directory Services + Remote Management Bootstrap

This runbook bootstraps a directory services domain (for lab identity) and
secures remote management for endpoints before any automation runs.

Notes:
- Use a dedicated local admin account for break-glass access.
- Use a separate lab-activity account for day-to-day testing.

## 0) Prepare endpoints (manual, per VM)
- Create a local admin account during first-boot/OOBE.
- Rename endpoints to match the inventory (e.g., `dc-01`, `ws-01`, `ws-02`).
- Reboot so hostname changes apply.

## 1) Populate identity secrets (vault)
Store directory service and local admin credentials in a vault file (copy from
`ansible/inventory/group_vars/all/vault.yml.example`):

```bash
ANSIBLE_CONFIG=ansible/ansible.cfg ansible-vault edit ansible/inventory/group_vars/all/vault.yml
```

If you don’t use `group_vars`, set the vault path in your inventory instead.

## 2) Bootstrap the identity service
Run the identity blueprint playbook against the identity host:

```bash
ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_identity.yml
```

## 3) Enforce static addressing + DNS records
Apply the static IPs defined in `data/hosts.yaml` and ensure directory service
DNS records exist for core endpoints.

```bash
ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_network_segments.yml
```

## 4) Issue internal CA certs for management endpoints
Use the internal PKI to issue and distribute management certificates.

```bash
ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_identity.yml
```

## 5) Tighten remote management validation
Once certs are trusted end-to-end, require full certificate validation in
your remote management client settings and automation inventory.
