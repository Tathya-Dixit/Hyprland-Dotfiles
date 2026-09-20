# Hyprland Dotfiles

A Spider-Man-themed Hyprland rice, built on Hyprland 0.55+'s Lua config system rather than the legacy `.conf`/hyprlang format. Deep red / near-black / cream palette across the bar, launcher, terminal, and lock screen, with a live glass/transparency effect throughout.

## What's in here

| Directory | Purpose |
|---|---|
| `hypr/` | Hyprland itself: `hyprland.lua` (main config), `binds.lua` (keybindings), `monitors.lua` (auto-generated monitor layout), `hyprlock.conf`, `hypridle.conf`, plus helper scripts |
| `waybar/` | Status bar config + Spider-Man theme (`style.css`), with several alternate themes under `waybar/themes/` |
| `rofi/` | App launcher, styled as a frosted-glass panel (`glass.rasi`) |
| `alacritty/` | Terminal config with an inline (no external theme import) color palette matched to the rest of the rice |
| `waypaper` | Wallpaper picker config |
| `fastfetch/` | System info fetch tool config |
| `nvim/` | Neovim config (lazy.nvim-managed plugins) |
| `Wallpapers/` | Wallpaper images |
| `.zshrc` | Shell config: prompt, aliases, zsh plugins |
| `install.sh` | Installs this repo onto a fresh Arch system |
| `backup.sh` | Pulls your live `~/.config` back into this repo (run this after making changes on your machine, before committing) |

## Requirements

- **Arch Linux** (or an Arch-based distro) — `install.sh` uses `pacman`/`paru` directly
- **Hyprland 0.55 or newer** — this config uses Hyprland's Lua config system (`hyprland.lua`), not the older `hyprland.conf` format. Older Hyprland versions won't understand these files.
- An **AUR helper** (`paru` or `yay`) for a few packages not in the official repos (`waypaper`, `swaync`, zsh plugins, Nerd Fonts)

## Installing

```bash
git clone https://github.com/Tathya-Dixit/Hyprland-Dotfiles.git
cd Hyprland-Dotfiles
./install.sh
```

`install.sh` will:
1. Install required packages (official repos, then AUR via `paru` or `yay`, whichever is found)
2. **Back up** any existing configs it would otherwise overwrite, to `~/.dotfiles-backup-<timestamp>/`
3. Copy every config folder into place under `~/.config/`
4. Make all scripts executable
5. Optionally set `zsh` as your default shell

It will **not** automatically:
- Log you out/reboot (needed once, so Hyprland picks up the Lua config on a fresh session)
- Pick a wallpaper for you — open `waypaper` afterward and choose one from `~/wallpaper`
- Install an AUR helper if you don't have one
- Configure anything hardware-specific (GPU drivers, per-machine monitor layout)

## Notable features

- **Live monitor management** — `hypr/scripts/display-menu.sh` is a rofi-driven menu for changing resolution, position, scale, rotation, mirroring, and enable/disable per display, applied live via `hyprctl eval` (the old `hyprctl keyword` doesn't work under the Lua config) and persisted to `monitors.lua`.
- **One-key transparency toggle** — `hypr/scripts/toggle-transparency.sh`, bound to `SUPER + ALT + T`, flips every window between the rice's glass opacity and fully opaque.
- **Glass theme** applied consistently across rofi, waybar, and the terminal — same base palette, same blur treatment (via Hyprland `layer_rule`s for the layer-shell surfaces).

## Keybindings

The full list lives in `hypr/binds.lua`. Highlights:

| Bind | Action |
|---|---|
| `SUPER + Return` / `Q` | Terminal |
| `SUPER + Space` | App launcher (rofi) |
| `SUPER + D` | Display manager menu |
| `SUPER + ALT + T` | Toggle transparency on/off |
| `SUPER + X` | Close window |
| `SUPER + F` | Toggle floating |
| `SUPER + [0-9]` | Switch workspace |
| `SUPER + SHIFT + [0-9]` | Move window to workspace |
| `SUPER + M` | Lock screen |

## A note on the color scheme

Colors are duplicated across a few files rather than pulled from one shared source (`alacritty.toml`, `waybar/style.css`, `rofi/glass.rasi` each define their own palette). If you fork this and want to re-theme it, you'll need to update the accent color (`#E4181E`) and background tones in each of those files individually.
