#!/usr/bin/env bash

# ==============================
# 01-core.sh
# Install base system, Xorg, WM, services
# ==============================

set -Eeuo pipefail

trap 'echo "❌ core failed at line $LINENO"; exit 1' ERR

# ===== update =====
echo "==> updating system..."
sudo pacman -Syu --noconfirm

# ===== base tools =====
echo "==> installing base tools..."
sudo pacman -S --needed --noconfirm \
  base-devel git curl wget unzip zip tar \
  neovim zsh tmux \
  btop fastfetch \
  ripgrep fd fzf \
  python python-pip \
  nodejs npm

# ===== xorg + wm =====
echo "==> installing Xorg + bspwm..."
sudo pacman -S --needed --noconfirm \
  xorg-server xorg-xinit \
  xorg-xrandr xorg-xsetroot xorg-xinput \
  bspwm sxhkd \
  alacritty rofi

# ===== system utils =====
echo "==> installing system utilities..."
sudo pacman -S --needed --noconfirm \
  networkmanager network-manager-applet \
  thunar thunar-volman gvfs tumbler \
  feh picom dunst polybar \
  flameshot \
  polkit-gnome \
  xdg-utils xdg-user-dirs xclip

# enable network
sudo systemctl enable NetworkManager

# ===== audio =====
echo "==> installing pipewire..."
sudo pacman -S --needed --noconfirm \
  pipewire wireplumber pipewire-pulse \
  pipewire-alsa pipewire-jack \
  pamixer pavucontrol

# ===== bluetooth =====
echo "==> installing bluetooth..."
sudo pacman -S --needed --noconfirm \
  bluez bluez-utils blueman

sudo systemctl enable bluetooth

# ===== fonts + theme =====
echo "==> installing fonts + themes..."
sudo pacman -S --needed --noconfirm \
  ttf-inter-font \
  ttf-jetbrains-mono-nerd \
  noto-fonts noto-fonts-emoji noto-fonts-cjk \
  gtk-engine-murrine gnome-themes-extra \
  papirus-icon-theme

# ===== extra apps =====
echo "==> installing extra apps..."
sudo pacman -S --needed --noconfirm \
  yazi zathura zathura-pdf-mupdf \
  nsxiv jq trash-cli brightnessctl playerctl

# ===== power =====
echo "==> installing tlp..."
sudo pacman -S --needed --noconfirm tlp
sudo systemctl enable tlp

# ===== user dirs =====
echo "==> creating user dirs..."
xdg-user-dirs-update

echo "==> core setup done ✅"
