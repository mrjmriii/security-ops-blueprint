# Project Planning Model (Sanitized)

## Purpose
Define how work is prioritized and which delivery model we use for each task,
without embedding vendor or environment specifics.

## Triage (Eisenhower Matrix)
- Urgent + Important: do now (same day).
- Important + Not Urgent: schedule (default).
- Urgent + Not Important: delegate or automate.
- Not Urgent + Not Important: drop or park.

## Delivery Model Selection
Prefer "waterfall when we can, agile when we can't, kanban when we can't agile."
- Waterfall: stable scope, linear dependencies, high-risk changes.
  - Phases: plan -> build -> validate -> rollback -> document.
- Agile: evolving requirements, incremental value.
  - Time-boxed iterations with definition of done.
- Kanban: interrupt-driven ops or continuous intake.
  - WIP limits and pull-based flow.

## Mixing Rules
- Foundational infrastructure changes default to waterfall.
- Detection tuning and dashboards default to agile.
- Break/fix and on-call flows default to kanban.

## Backlog
- Source of truth: `docs/backlog.md`.
- Each entry includes Eisenhower quadrant + delivery mode + exit criteria.
- Review weekly; re-triage urgent items immediately.
