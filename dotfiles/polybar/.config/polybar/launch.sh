#!/usr/bin/env bash

# kill all polybar instances
killall -q polybar

# wait until all processes are gone
while pgrep -u $UID -x polybar >/dev/null; do
    sleep 1
done

# launch bar
polybar main &