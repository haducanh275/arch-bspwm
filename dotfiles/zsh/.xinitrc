#!/usr/bin/env bash

# =========================
# LOAD X RESOURCES
# =========================
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# =========================
# START SERVICES
# =========================

# compositor
pgrep -x picom > /dev/null || picom -b &

# keybind daemon
pgrep -x sxhkd > /dev/null || sxhkd &

# notifications
pgrep -x dunst > /dev/null || dunst &

# network tray
pgrep -x nm-applet > /dev/null || nm-applet &

# clipboard
pgrep -x greenclip > /dev/null || greenclip daemon &

# =========================
# WALLPAPER (safe)
# =========================
WALL="$HOME/.config/bspwm/wall.jpg"
if [ -f "$WALL" ]; then
    feh --bg-fill "$WALL"
else
    xsetroot -solid "#2E3440"
fi

# =========================
# POLYBAR
# =========================
[ -x "$HOME/.config/polybar/launch.sh" ] && \
    "$HOME/.config/polybar/launch.sh" &

# =========================
# START WINDOW MANAGER
# =========================
exec bspwm