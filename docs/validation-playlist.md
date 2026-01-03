# Blueprint Validation Playlist

## Purpose
Quick, repeatable checks for DNS, reachability, HTTPS, and TLS trust.

## Run
```bash
scripts/validate-blueprint.sh
```

By default, the script writes a time-stamped log under `docs/logs/` and prints the path.

Override the log path:
```bash
OUT_FILE=docs/logs/blueprint-validate-$(date +%Y%m%d-%H%M%S).log scripts/validate-blueprint.sh
```

Disable logging:
```bash
NO_LOG=1 scripts/validate-blueprint.sh
```

## What the output means
- **DNS**: `getent hosts` resolution via edge firewall / directory services.
- **PING**: ICMP reachability to the expected IP.
- **HTTPS**: HTTP status code + `OK` (trusted) or `UNTRUSTED` (cert chain fails).
- **TLS**: `OK` when the internal CA verifies the leaf cert.

Expected signals:
- `200` or `302` on HTTPS (login redirects count as healthy).
- `TLS OK` for all services that use internal CA leaf certs.
- SIEM dashboard listens on `:5601` unless a reverse proxy terminates on 443.
- Dashboard UI is reachable over HTTPS.

## Troubleshooting Map
### DNS FAIL
1. On controller:
   - `resolvectl status`
   - `resolvectl query <hostname>`
2. On edge firewall:
   - Confirm DHCP static map + DNS host override.
   - Verify DHCP domain/search list includes the lab domain.
3. On directory services:
   - Ensure authoritative DNS is running for the lab domain.

### PING FAIL
1. Check edge firewall DHCP lease / static map.
2. Verify VM is powered on and NIC is attached to the correct bridge.
3. On hypervisor: confirm the VM is running in the management UI.

### HTTPS UNTRUSTED / TLS BAD
1. Confirm internal CA is installed on the controller workstation.
2. Verify the service is using the correct leaf cert + key pair.
3. Confirm any reverse proxy points to the expected cert and key.
4. Check time sync on both client and server (time drift can break TLS).

### HTTPS FAIL (no status code)
1. Check the service process (web server or app runtime).
2. Validate configuration syntax (web server config test).
3. Check edge firewall rules for the host and port.

## Backup Health (hypervisor -> backup appliance)
1. Storage reachable from hypervisor (management UI or CLI).
2. Backup job configured and enabled.
3. Latest backup activity shows a successful run.
4. Snapshots present on the backup appliance.

### Backup success indicators
- Backup logs show completion without errors.
- Snapshot entries exist for recent timestamps.
- Backup appliance UI reflects the latest job results.

## Notes
- This playlist assumes the internal CA is the trust anchor for TLS.
- If a service still uses a self-signed cert, it will show as `UNTRUSTED`.
