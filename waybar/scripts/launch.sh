#!/bin/zsh

killall -q waybar

# Define the log file path in the temporary directory
LOG_FILE="$HOME/.gemini/tmp/17de47619004846f31772b90816d9419c96c2edbe07f115f64e4814d3a0e506d/waybar_launch.log"

# Launch Waybar and redirect stdout and stderr to the log file
waybar &> "$LOG_FILE" &
