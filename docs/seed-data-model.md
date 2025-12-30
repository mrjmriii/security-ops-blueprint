# Seed data model (bootstrap)

This folder provides the initial `data/hosts.yaml` and `data/networks.yaml`.

## What this enables

- A canonical source of truth for:
  - hostnames
  - roles/groups
  - management-plane IPs
  - site/network parameters

This is designed to be rendered later into:
- Ansible inventory (`generated/inventories/...`)
- Terraform inputs (`terraform/envs/...`)
- Firewall intent (edge firewall rules, DHCP reservations, DNS)

## Bootstrap assumptions (edit as needed)

- Flat LAN: `192.0.2.0/24`
- Edge (edge firewall): `192.0.2.1`
- Hypervisor (hypervisor): `192.0.2.240`
- Controller (`ctl-laptop`): `192.0.2.250`
- Lab router (optional): `192.0.2.252` (routes lab subnets)

## Next step after dropping in

1. Commit these seed files.
2. Add a small inventory renderer (or use a direct Ansible inventory plugin).
3. Write `ansible/playbooks/bootstrap.yml` to converge baseline services.

Generated: 2025-12-21
