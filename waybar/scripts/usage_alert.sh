#!/bin/bash

# Type: "cpu" or "memory"
TYPE=$1
# Current value passed from waybar
VALUE=$2
# Threshold
THRESHOLD=90
# State file
STATE_FILE="/tmp/waybar-${TYPE}-notified"

# If state file doesn't exist, initialize it
if [ ! -f "$STATE_FILE" ]; then
    echo "0" > "$STATE_FILE"
fi

last_notified=$(cat "$STATE_FILE")

if [ "$VALUE" -ge "$THRESHOLD" ]; then
    if [ "$last_notified" -eq 0 ]; then
        if [ "$TYPE" == "cpu" ]; then
            notify-send -u critical "High CPU Usage" "CPU usage is at ${VALUE}%!"
        else
            notify-send -u critical "High Memory Usage" "Memory usage is at ${VALUE}%!"
        fi
        echo "1" > "$STATE_FILE"
    fi
else
    # Reset when usage drops below threshold (with a small buffer to avoid flickering notifications)
    if [ "$VALUE" -lt $((THRESHOLD - 5)) ]; then
        echo "0" > "$STATE_FILE"
    fi
fi
