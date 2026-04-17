#!/usr/bin/env bash

# ==============================
# Arch BSPWM Setup - Commander
# ==============================

set -Eeuo pipefail

LOG_FILE="$HOME/arch_install.log"

# ===== logging =====
exec > >(tee -a "$LOG_FILE") 2>&1

# ===== error handler =====
trap 'echo -e "\n❌ error at line $LINENO. check log: $LOG_FILE"; exit 1' ERR

# ===== check Arch =====
if ! grep -q "Arch" /etc/os-release; then
  echo "❌ this is not Arch Linux. exiting..."
  exit 1
fi

# ===== sudo keep-alive =====
echo "🔑 requesting sudo..."
sudo -v

( while true; do sudo -n true; sleep 60; done ) &
SUDO_PID=$!
trap 'kill $SUDO_PID' EXIT

# ===== variables =====
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ===== modules =====
modules=(
  "scripts/01-core.sh"
  "scripts/02-aur.sh"
  "scripts/03-dotfiles.sh"
)

# ===== run modules =====
echo "🚀 starting setup..."

for module in "${modules[@]}"; do
  if [[ -f "$REPO_DIR/$module" ]]; then
    echo "➡️ running $module"
    chmod +x "$REPO_DIR/$module"
    bash "$REPO_DIR/$module"
  else
    echo "⚠️ missing $module, skipping..."
  fi
done

# ===== finish =====
echo "\n🎉 setup complete!"
echo "👉 reboot or run 'startx' to enter bspwm"