# Maintenance Bypass (Lab-Only)

Purpose: allow time-boxed exceptions for patching or installations without permanently weakening controls.

## Preferred approach (temporary IP-based bypass)
1. Assign the host a temporary static IP or DHCP reservation.
2. Add that IP to a **temporary allow list** in the edge firewall and IDS/IPS.
3. Set an expiration note and remove it after the task completes.

Why this works:
- Auditable, reversible, and low-risk.
- Avoids permanent rule creep.
- Keeps changes scoped to a single host.

## Alternate approach (alias + quick allow rule)
1. Create a firewall alias (e.g., `TEMP_BYPASS_HOSTS`).
2. Add a top-of-list **quick allow** rule for the alias.
3. Remove the host from the alias once maintenance ends.

## What not to do
- Disable inspection globally.
- Leave open rules with no expiry.
- Suppress alerts permanently.

## Validation
- Confirm only the intended host is allowed.
- Confirm logging still works for other hosts.
- Remove the bypass and re-validate baseline posture.
