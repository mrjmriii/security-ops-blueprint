# Infrastructure Baselines (Read-Only)

This directory contains authoritative baseline captures of the lab environment.

⚠️ **DO NOT EDIT THESE FILES**
- Changes must be made by re-capturing state from live systems
- Updates result in a new baseline tag (e.g. baseline-v2)
- These files are reference truth for automation and drift detection

Treat this directory as immutable history.

## edge firewall Facts Model

edge firewall facts are collected via read-only SSH and config export.
Standard Ansible `gather_facts` is intentionally disabled.
Facts are normalized and stored under `data/facts/edge-firewall/`.
