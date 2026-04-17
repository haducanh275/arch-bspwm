#!/usr/bin/env bash

# ==============================
# 02-aur.sh
# Install paru + AUR packages
# ==============================

set -Eeuo pipefail

trap 'echo "❌ aur failed at line $LINENO"; exit 1' ERR

# ===== check paru =====
if ! command -v paru >/dev/null 2>&1; then
  echo "==> installing paru (AUR helper)..."

  TMP_DIR=$(mktemp -d)
  cd "$TMP_DIR"

  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si --noconfirm

  cd ~
  rm -rf "$TMP_DIR"
else
  echo "==> paru already installed, skipping..."
fi

# ===== install AUR packages =====
echo "==> installing AUR packages..."

paru -S --needed --noconfirm \
  brave-bin \
  nordic-theme \
  bibata-cursor-theme \
  greenclip \
  bemoji

echo "==> aur setup done ✨"