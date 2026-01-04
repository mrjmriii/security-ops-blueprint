# Incident Report: Blueprint Sanitization Exposure (2026-01-04)

## Purpose
Document a public blueprint exposure event, the remediation taken, and the preventive actions that followed.

## Summary
On 2026-01-04, vendor-specific edge firewall DNS filtering content and guest/WAP policy notes derived from an internal repo were pushed to the public blueprint. The content included non-public naming patterns and private addressing examples. The exposure was removed by rewriting public history and replacing it with vendor-neutral guidance. A responsible AI exposure response policy was added to prevent recurrence.

## Impact
- Public repo briefly included vendor-specific implementation details.
- No credentials, keys, or secrets were exposed.
- Potential disclosure of internal topology intent and naming conventions.

## Detection
- Manual review flagged the non-sanitized content shortly after publication.

## Root cause
- Sanitization workflow was bypassed for a fast sync.
- AI-assisted edits were not routed through a publish checklist.

## Timeline
- 2026-01-04: Unsanitized content published to the public repo.
- 2026-01-04: History rewritten to remove exposure; vendor-neutral replacements committed.
- 2026-01-04: Responsible AI exposure response policy added.

## Remediation
- Removed the exposed commit from public history via force-with-lease.
- Replaced the removed content with vendor-neutral edge DNS filtering and guest/WAP guidance.
- Added a responsible AI exposure response policy and validation checklist.

## Lessons learned
- Public updates must flow through a sanitize-and-review gate.
- AI-assisted changes need explicit publish classification before merge.

## Preventive actions
- Require sanitization and validation checks before public publish.
- Add a two-person review gate for public releases.
- Enforce pre-publish scans for RFC1918 ranges, org-specific names, and secrets.
- Use role-based terms (edge firewall, DNS filter, guest WLAN) instead of vendor names.

## Preconditions
- Access to the public repo history and validation tools (`rg`, doc lint script).

## Steps to run
1) Review commit history around the incident window.
2) Verify the exposed files no longer exist in the public repo.
3) Validate that the replacement guidance is vendor-neutral.

## Validation checklist
- `rg -n "192\\.168\\.|10\\.|172\\.(1[6-9]|2[0-9]|3[0-1])\\." docs ansible data` (expect no hits).
- `rg -n "BEGIN (RSA|EC|OPENSSH) PRIVATE KEY|AKIA" -S .` (expect no hits).
- `scripts/validate-docs.sh`

## Rollback/Revert
- If a rollback is required, restore the last clean public commit and reapply the vendor-neutral guidance.
