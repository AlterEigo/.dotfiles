#!/usr/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar top&
polybar bottom_left&
polybar bottom_right&

echo "Polybar launched..."
