#!/bin/bash

# Get the wallpaper folder from waypaper configuration
CONFIG_FILE="$HOME/.config/waypaper/config.ini"
WALLPAPER_FOLDER=$(grep "^folder =" "$CONFIG_FILE" | grep -v "subfolders" | cut -d' ' -f3 | sed "s|^~|$HOME|")

# Check if the folder exists
if [ ! -d "$WALLPAPER_FOLDER" ]; then
    echo "Error: Wallpaper folder $WALLPAPER_FOLDER does not exist."
    exit 1
fi

# List images and use rofi to select one with icons
# Formatting for rofi dmenu: entry\0icon\x1f/path/to/icon
SELECTED_WALLPAPER=$(find "$WALLPAPER_FOLDER" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) -printf "%f\n" | sort | while read -r filename; do
    printf "%s\0icon\x1f%s\n" "$filename" "$WALLPAPER_FOLDER/$filename"
done | rofi -dmenu -i -p "Select Wallpaper:" -show-icons -theme-str 'window { width: 800px; } listview { columns: 3; lines: 3; spacing: 10px; } element { orientation: vertical; padding: 10px; } element-icon { size: 150px; } element-text { enabled: false; }')

# If a wallpaper was selected, set it using waypaper
if [ -n "$SELECTED_WALLPAPER" ]; then
    waypaper --wallpaper "$WALLPAPER_FOLDER/$SELECTED_WALLPAPER"
fi
