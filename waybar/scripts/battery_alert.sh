#!/bin/bash

# Path to battery information
BATTERY_PATH="/sys/class/power_supply/BAT0"
battery_level=$(cat "$BATTERY_PATH/capacity")
battery_status=$(cat "$BATTERY_PATH/status")
STATE_FILE="/tmp/waybar-battery-notified"

# If state file doesn't exist, initialize it
if [ ! -f "$STATE_FILE" ]; then
    echo "100" > "$STATE_FILE"
fi

last_notified=$(cat "$STATE_FILE")

# Only alert when discharging
if [ "$battery_status" = "Discharging" ]; then
    # Check thresholds: 10%, 15%, 20%
    if [ "$battery_level" -le 10 ] && [ "$last_notified" -gt 10 ]; then
        notify-send -u critical "Battery Critical" "Battery level is at ${battery_level}%!"
        echo "10" > "$STATE_FILE"
    elif [ "$battery_level" -le 15 ] && [ "$last_notified" -gt 15 ]; then
        notify-send -u normal "Battery Low" "Battery level is at ${battery_level}%!"
        echo "15" > "$STATE_FILE"
    elif [ "$battery_level" -le 20 ] && [ "$last_notified" -gt 20 ]; then
        notify-send -u low "Battery Warning" "Battery level is at ${battery_level}%!"
        echo "20" > "$STATE_FILE"
    fi
elif [ "$battery_status" = "Charging" ] || [ "$battery_status" = "Full" ]; then
    # Reset state if charging and level is above thresholds
    if [ "$battery_level" -gt 20 ]; then
        echo "100" > "$STATE_FILE"
    fi
fi
