# Blueprint Sanitization + Publish Workflow

## Purpose
- Keep this repo as a sanitized pseudotwin of the internal homelab IaC.
- Provide a repeatable, reviewable process for publishing updates safely.

## Preconditions
- Access to the internal repo (private clone path or CI checkout).
- `scripts/sanitize-blueprint.sh` available in this repo.
- Mapping file updated: `data/sanitization-map.tsv`.
- Replacement rules updated (optional): `data/sanitization-replacements.tsv`.
- `rg` and `perl` available on the workstation or CI runner.

## Steps to run
1) Dry run the sanitizer:
   - `INTERNAL_ROOT=~/src/internal-homelab DRY_RUN=1 scripts/sanitize-blueprint.sh`
2) Review staged output for placeholders and RFC1918 IPs.
3) Apply updates to the blueprint:
   - `INTERNAL_ROOT=~/src/internal-homelab DRY_RUN=0 scripts/sanitize-blueprint.sh`
4) Run validation:
   - `scripts/validate-blueprint.sh`

## Validation checklist
- `scripts/validate-blueprint.sh`
- `rg -n "192\\.168\\.|10\\.|172\\.(1[6-9]|2[0-9]|3[0-1])\\." docs ansible data`
- `rg -n "BEGIN (RSA|EC|OPENSSH) PRIVATE KEY|AKIA" -S .`

## Rollback
- `git restore .` to discard staged changes.
- `git revert <commit>` if already committed.

## Automation note (template only)
- A starter workflow template lives at `.github/workflows/blueprint-sanitize.yml.example`.
- It is disabled by default and expects private repo checkout secrets.
