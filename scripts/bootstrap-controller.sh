#!/usr/bin/env bash
set -euo pipefail

# Bootstrap controller dev tooling for this repo.
# Assumes mise is already installed and shell activation is enabled.
# Run from repo root.

if [[ ! -f ".tool-versions" ]]; then
  echo "ERROR: Run from repo root (missing .tool-versions)"
  exit 1
fi

echo "[1/5] Installing OS packages (make, jq, git, python venv deps)..."
sudo apt update
sudo apt install -y make jq git curl ca-certificates python3-venv python3-pip

echo "[2/5] Installing mise tool versions..."
mise install

echo "[3/5] Creating repo-local venv (.venv)..."
python -m venv .venv
# shellcheck disable=SC1091
source .venv/bin/activate
pip install -U pip
pip install -r requirements-dev.txt

echo "[4/5] Installing pre-commit hooks (if config exists)..."
if [[ -f ".pre-commit-config.yaml" ]]; then
  pre-commit install
else
  echo "No .pre-commit-config.yaml found; skipping hook install."
fi

echo "[5/5] Quick verification..."
python --version
terraform version | head -n 1 || true
ansible --version | head -n 1 || true
pre-commit --version || true

echo "Bootstrap complete."
