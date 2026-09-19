-- Migrated from keybindings.conf (hyprlang) to Hyprland 0.55+ Lua config.
-- Reference: https://wiki.hypr.land/Configuring/Basics/Binds/

local terminal    = "alacritty"
local fileManager = "nautilus"
local menu        = "rofi -show drun"
local browser     = "brave"
local editor      = "code"
local wifi        = "wifimenu"
local notes       = "obsidian"

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("~/.config/hypr/scripts/display-menu.sh"))
hl.bind(mainMod .. " + ALT + T", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-transparency.sh"))

hl.bind(mainMod .. " + Q",      hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + X",      hl.dsp.window.close())
-- hl.bind(mainMod .. " + M", hl.dsp.exit()) -- exit hyprland
hl.bind(mainMod .. " + W",           hl.dsp.exec_cmd(wifi))
hl.bind(mainMod .. " + SHIFT + B",   hl.dsp.exec_cmd("rofi-bluetooth"))
hl.bind(mainMod .. " + E",           hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + F",           hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Space",       hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + T",           hl.dsp.window.pseudo()) -- dwindle Toggle TileView
hl.bind(mainMod .. " + J",           hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + B",           hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + R",           hl.dsp.exec_cmd("~/.config/waybar/scripts/launch.sh"))
hl.bind(mainMod .. " + SHIFT + T",   hl.dsp.exec_cmd("~/.config/waybar/scripts/theme-selector.sh"))
hl.bind(mainMod .. " + K",           hl.dsp.exec_cmd("killall waybar"))
hl.bind(mainMod .. " + C",           hl.dsp.exec_cmd(editor))
hl.bind(mainMod .. " + N",           hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-night-mode.sh"))
hl.bind(mainMod .. " + plus",        hl.dsp.exec_cmd("hyprctl hyprsunset temperature +500"))
hl.bind(mainMod .. " + minus",       hl.dsp.exec_cmd("hyprctl hyprsunset temperature -500"))

hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("rofi -show emoji"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("rofi -show calc -no-show-match -no-sort"))

hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/waypaper/select_wallpaper.sh"))

hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(notes))

hl.bind(mainMod .. " + ALT + S",         hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + ALT + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m window"))

-- Move focus with mainMod + CTRL + arrow keys
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.focus({ direction = "down" }))

-- Same, with hjkl (kept identical to the original mapping, l/h reversed as-is)
hl.bind(mainMod .. " + CTRL + l", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + h", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,          hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,  hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad) - was commented out in the original .conf
-- hl.bind(mainMod .. " + H",         hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + Right", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + Left",  hl.dsp.focus({ workspace = "m-1" }))

hl.bind(mainMod .. " + l", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + h", hl.dsp.focus({ workspace = "m-1" }))

hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + Left",  hl.dsp.window.move({ workspace = "m-1" }))

hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ workspace = "m-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",          hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",       hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true })

-- Power options
hl.bind(mainMod .. " + CTRL + ALT + p", hl.dsp.exec_cmd("shutdown now"))
hl.bind(mainMod .. " + M",              hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + CTRL + ALT + L", hl.dsp.exec_cmd("systemctl suspend"))
hl.bind(mainMod .. " + CTRL + ALT + R", hl.dsp.exec_cmd("reboot"))
