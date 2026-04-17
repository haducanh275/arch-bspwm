#!/usr/bin/env bash

# ==============================
# 03-dotfiles.sh
# Setup dotfiles with GNU Stow
# ==============================

set -Eeuo pipefail

trap 'echo "❌ dotfiles failed at line $LINENO"; exit 1' ERR

# ===== install stow =====
echo "==> installing stow..."
sudo pacman -S --needed --noconfirm stow

# ===== ensure config dirs =====
echo "==> preparing config directories..."
mkdir -p ~/.config/{bspwm,sxhkd,polybar,alacritty,rofi,picom}

# ===== stow dotfiles =====
echo "==> linking dotfiles..."
cd "$REPO_DIR/dotfiles"

for dir in */; do
  stow -D "${dir%/}" 2>/dev/null || true
  stow "${dir%/}"
  echo "✅ linked ${dir%/}"
done

# ===== set zsh default shell =====
if [[ "$SHELL" != "/bin/zsh" ]]; then
  echo "==> setting zsh as default shell..."
  chsh -s /bin/zsh
fi

# ===== apply theme =====
echo "==> applying GTK theme..."

if command -v gsettings >/dev/null 2>&1; then
  gsettings set org.gnome.desktop.interface gtk-theme "Nordic" || true
  gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark" || true
  gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Classic" || true
fi

# ===== user dirs =====
xdg-user-dirs-update

echo "==> dotfiles setup done 🎨"S