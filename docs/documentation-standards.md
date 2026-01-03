# Documentation Standards (Sanitized)

## Purpose
Keep documentation consistent, searchable, and aligned to `docs/vision.md`.

## Required Sections (Runbooks)
1) Purpose
2) Preconditions
3) Steps to run
4) Validation checklist
5) Rollback/Revert

## Recommended Sections (Plans)
- Purpose
- Scope
- Dependencies
- Risks
- Validation

## Naming Rules
- Use canonical terms from `docs/terminology.md`.
- Mark unsafe settings as **lab-only** and include rollback steps.
- Prefer explicit role names over vendor-specific labels.

## Evidence
- Validation logs are recorded in `docs/logs/`.
- Summaries go to `docs/progress.md`.
