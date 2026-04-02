#!/bin/bash

# Path to the wallpaper passed by waypaper
NEW_WALLPAPER="$1"

# Path to the hyprlock configuration file
HYPRLOCK_CONFIG="$HOME/.config/hypr/hyprlock.conf"

# Check if the config file exists
if [ -f "$HYPRLOCK_CONFIG" ]; then
    # Use sed to replace the path in the background block specifically
    # It finds the range between 'background {' and its closing '}'
    # and replaces the 'path =' line within that range.
    sed -i '/background {/,/}/ s|path = .*|path = '"$NEW_WALLPAPER"'|' "$HYPRLOCK_CONFIG"
fi
