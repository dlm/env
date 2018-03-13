#!/usr/bin/env sh

# setting to 1 allows us to have a bar on each monitor
USE_MULTIMON=0

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr" && [ $USE_MULTIMON = 1 ]; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --config=$HOME/.polybar/config example &
    done
else
    polybar --config=$HOME/.polybar/config example &
fi

echo "Bars launched..."
