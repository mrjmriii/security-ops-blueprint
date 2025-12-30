#!/usr/bin/env bash
set -euo pipefail

# -----------------------------------------------------------------------------
# Identity-aware workstation bootstrap
# -----------------------------------------------------------------------------
# This script prepares a workstation in a zero-trust, reversible way.
#
# Responsibilities:
#   - Install core packages
#   - Acquire operator identity (dotfiles)
#   - Verify identity integrity
#   - Link identity into the system safely
#
# Non-responsibilities:
#   - Editing dotfiles
#   - Defining aliases or shell behavior
#   - Making irreversible changes
# -----------------------------------------------------------------------------

log()  { printf "\n[*] %s\n" "$*"; }
ok()   { printf "[✓] %s\n" "$*"; }
warn() { printf "[!] %s\n" "$*" >&2; }
die()  { printf "[✗] %s\n" "$*" >&2; exit 1; }

# -----------------------------------------------------------------------------
# Configuration (override via environment)
# -----------------------------------------------------------------------------

OPERATOR_DOTFILES_REPO="${OPERATOR_DOTFILES_REPO:-git@github.com:mrjmriii/operator-dotfiles.git}"
OPERATOR_DOTFILES_BRANCH="${OPERATOR_DOTFILES_BRANCH:-master}"
IDENTITY_PROFILE="${IDENTITY_PROFILE:-default}"

SRC_DIR="$HOME/src"
IDENTITY_DIR="$SRC_DIR/operator-dotfiles"
SHELL_CONFIG_LINK="$HOME/.config/shell"

TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

# -----------------------------------------------------------------------------
# Preconditions
# -----------------------------------------------------------------------------

log "Starting workstation bootstrap"

command -v sudo >/dev/null || die "sudo not available"
command -v apt  >/dev/null || die "apt not available (Pop!/Ubuntu expected)"

# -----------------------------------------------------------------------------
# Base system packages
# -----------------------------------------------------------------------------

log "Updating package index"
sudo apt update -y

log "Installing core packages"
sudo apt install -y \
  git \
  curl \
  ca-certificates \
  gnupg \
  lsb-release \
  openssh-server \
  zsh \
  eza

# -----------------------------------------------------------------------------
# SSH service
# -----------------------------------------------------------------------------

if systemctl is-enabled ssh >/dev/null 2>&1; then
  ok "SSH already enabled"
else
  sudo systemctl enable --now ssh
  ok "SSH enabled"
fi

# -----------------------------------------------------------------------------
# Identity acquisition
# -----------------------------------------------------------------------------

log "Ensuring src directory exists: $SRC_DIR"
mkdir -p "$SRC_DIR"

if [[ ! -d "$IDENTITY_DIR" ]]; then
  log "Cloning operator identity"
  git clone -b "$OPERATOR_DOTFILES_BRANCH" "$OPERATOR_DOTFILES_REPO" "$IDENTITY_DIR" \
    || die "Failed to clone operator identity"
else
  log "Operator identity already present"

  if [[ -d "$IDENTITY_DIR/.git" ]]; then
    if ! git -C "$IDENTITY_DIR" diff --quiet; then
      die "Operator identity repo has uncommitted changes; aborting"
    fi
    ok "Operator identity repo clean"
  else
    die "Identity directory exists but is not a git repo"
  fi
fi

# -----------------------------------------------------------------------------
# Shell config linking (zero trust)
# -----------------------------------------------------------------------------

log "Preparing shell configuration"

mkdir -p "$HOME/.config"

if [[ -e "$SHELL_CONFIG_LINK" && ! -L "$SHELL_CONFIG_LINK" ]]; then
  warn "Existing shell config detected, backing up"
  mv "$SHELL_CONFIG_LINK" "$SHELL_CONFIG_LINK.bak.$TIMESTAMP"
fi

EXPECTED_TARGET="$IDENTITY_DIR/.config/shell"

if [[ -L "$SHELL_CONFIG_LINK" ]]; then
  CURRENT_TARGET="$(readlink "$SHELL_CONFIG_LINK")"
  if [[ "$CURRENT_TARGET" == "$EXPECTED_TARGET" ]]; then
    ok "Shell config already correctly linked"
  else
    die "Shell config symlink points to unexpected location: $CURRENT_TARGET"
  fi
else
  ln -s "$EXPECTED_TARGET" "$SHELL_CONFIG_LINK"
  ok "Shell config linked"
fi

# -----------------------------------------------------------------------------
# Default shell
# -----------------------------------------------------------------------------

if [[ "$SHELL" != */zsh ]]; then
  log "Setting default shell to zsh"
  chsh -s "$(command -v zsh)"
else
  ok "Default shell already zsh"
fi

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------

ok "Workstation bootstrap complete"
echo "[i] Log out and log back in for all changes to apply"
