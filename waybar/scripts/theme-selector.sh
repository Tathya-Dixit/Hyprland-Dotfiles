#!/bin/zsh

CONFIG_DIR="/home/tathya/.config/waybar"
THEMES_DIR="$CONFIG_DIR/themes"

# Get theme list
themes=$(ls "$THEMES_DIR")

# Use rofi for selection
selected_theme=$(echo "$themes" | rofi -dmenu -p "Select Waybar Theme")

if [[ -n "$selected_theme" ]]; then
    echo "Switching to theme: $selected_theme"
    
    # Copy theme files
    cp "$THEMES_DIR/$selected_theme/config.jsonc" "$CONFIG_DIR/config.jsonc"
    cp "$THEMES_DIR/$selected_theme/style.css" "$CONFIG_DIR/style.css"
    
    # Restart Waybar
    "$CONFIG_DIR/scripts/launch.sh"
    
    notify-send "Waybar Theme" "Theme changed to $selected_theme"
else
    echo "No theme selected."
fi
