#!/usr/bin/env bash
# Toggles all-window transparency fully off/on for Hyprland's Lua config.
# Deps: hyprctl

set -euo pipefail

# These should match the "glass" values in your hyprland.lua decoration
# block. If you tweak the rice's opacity later, update these two too.
GLASS_ACTIVE=0.8
GLASS_INACTIVE=0.6

current=$(hyprctl getoption decoration.active_opacity | awk '/float:/ {print $2}')

# Treat anything close to 1.0 as "currently opaque" -> turn glass back on.
if awk -v c="$current" 'BEGIN{exit !(c >= 0.99)}'; then
    hyprctl eval "hl.config({ decoration = { active_opacity = $GLASS_ACTIVE, inactive_opacity = $GLASS_INACTIVE } })"
    notify-send "Transparency" "Glass mode on" 2>/dev/null || true
else
    hyprctl eval "hl.config({ decoration = { active_opacity = 1.0, inactive_opacity = 1.0 } })"
    notify-send "Transparency" "Glass mode off (fully opaque)" 2>/dev/null || true
fi
