# Responsible AI Exposure Response Policy (Blueprint)

## Purpose
Define how we prevent and respond to accidental public exposure when AI-assisted changes are used in this public blueprint repo.

## Scope
- Applies to docs, playbooks, templates, and data files in this repo.
- Covers any AI-assisted content that may be derived from internal sources.

## Policy
- AI-assisted output is treated as untrusted until reviewed.
- Public content must remain vendor-neutral and sanitized.
- Internal naming patterns, private addressing, and vendor-specific implementations must not appear in this repo.
- Any exposure, regardless of size, triggers the incident response steps below.

## Prevention controls
- Use a publish checklist that includes sanitization and validation checks.
- Require two-person review for public releases.
- Prefer role-based terms (edge firewall, DNS filter, guest WLAN) over vendor names.
- Do not copy/paste internal configs or host inventories into public files.
- Use reserved example ranges and domains in public examples (example.net, 198.18.0.0/15).

## Incident response steps (AI exposure)
1) Contain: pause publishing and remove the exposed content from the public repo.
2) Assess: identify all affected files and the exposure window.
3) Remediate: replace with sanitized, vendor-neutral guidance.
4) Decide on history rewrite: use force-with-lease if exposure must be removed from public history.
5) Document: create an incident report in `docs/incidents/`.
6) Validate: run the validation checklist before republishing.
7) Review: capture lessons learned and update safeguards.

## Preconditions
- Access to the repo and the ability to run validation tools.
- Ability to coordinate a history rewrite if required.

## Steps to run (pre-publish)
1) Classify the change: public-safe or internal-only.
2) Sanitize content or block publication if not public-safe.
3) Run validation checks and doc lint.
4) Obtain peer review before merge.

## Validation checklist
- `rg -n "192\\.168\\.|10\\.|172\\.(1[6-9]|2[0-9]|3[0-1])\\." docs ansible data` (expect no hits).
- `rg -n "BEGIN (RSA|EC|OPENSSH) PRIVATE KEY|AKIA" -S .` (expect no hits).
- `scripts/validate-docs.sh`

## Rollback/Revert
- Changes to this policy follow normal change control; if a temporary exception is required, document it with an explicit time limit and owner.
