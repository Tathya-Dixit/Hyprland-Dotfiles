#!/usr/bin/env bash
# install.sh -- installs this dotfiles repo onto an Arch Linux system.
# Copies configs from this repo into ~/.config (and $HOME), the reverse
# of backup.sh. Existing configs are backed up first, never silently
# overwritten.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

c_green() { printf '\033[32m%s\033[0m\n' "$1"; }
c_yellow() { printf '\033[33m%s\033[0m\n' "$1"; }
c_red() { printf '\033[31m%s\033[0m\n' "$1"; }

# --- Sanity check: this is an Arch-based rice ---
if ! command -v pacman >/dev/null 2>&1; then
    c_red "pacman not found -- this install script is written for Arch Linux."
    c_yellow "You can still copy the config folders manually; see README.md."
    exit 1
fi

# --- Dependencies ---
PACMAN_PKGS=(
    hyprland hypridle hyprlock waybar rofi alacritty
    neovim zsh git jq playerctl brightnessctl
    networkmanager network-manager-applet bluez bluez-utils
    fastfetch eza bat reflector geany firefox
)

# AUR packages -- need an AUR helper. Both paru and yay are checked for,
# in that order; whichever is found first is used.
AUR_PKGS=(
    swaync waypaper swww
    zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search
    fzf-tab-git
    ttf-cascadia-code-nerd ttf-jetbrains-mono-nerd
)

c_green "==> Installing official repo packages..."
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

AUR_HELPER=""
if command -v paru >/dev/null 2>&1; then
    AUR_HELPER="paru"
elif command -v yay >/dev/null 2>&1; then
    AUR_HELPER="yay"
fi

if [ -n "$AUR_HELPER" ]; then
    c_green "==> Installing AUR packages via $AUR_HELPER..."
    "$AUR_HELPER" -S --needed --noconfirm "${AUR_PKGS[@]}"
else
    c_yellow "No AUR helper found (checked for paru and yay) -- skipping AUR packages."
    c_yellow "Install these manually once you have an AUR helper set up:"
    printf '    %s\n' "${AUR_PKGS[@]}"
fi

# --- Back up anything that already exists before touching it ---
mkdir -p "$BACKUP_DIR"
c_green "==> Backing up any existing configs to $BACKUP_DIR"

backup_if_exists() {
    local target="$1"
    if [ -e "$target" ]; then
        mkdir -p "$(dirname "$BACKUP_DIR/${target#$HOME/}")"
        mv "$target" "$BACKUP_DIR/${target#$HOME/}"
    fi
}

backup_if_exists "$HOME/.zshrc"
backup_if_exists "$HOME/.config/hypr"
backup_if_exists "$HOME/.config/waybar"
backup_if_exists "$HOME/.config/waypaper"
backup_if_exists "$HOME/.config/alacritty"
backup_if_exists "$HOME/.config/rofi"
backup_if_exists "$HOME/.config/fastfetch"
backup_if_exists "$HOME/.config/nvim"

# --- Copy configs from the repo into place ---
c_green "==> Copying configs into ~/.config"
mkdir -p "$HOME/.config"

cp -r "$REPO_DIR/hypr"       "$HOME/.config/hypr"
cp -r "$REPO_DIR/waybar"     "$HOME/.config/waybar"
cp -r "$REPO_DIR/waypaper"   "$HOME/.config/waypaper"
cp -r "$REPO_DIR/alacritty"  "$HOME/.config/alacritty"
cp -r "$REPO_DIR/rofi"       "$HOME/.config/rofi"
cp -r "$REPO_DIR/fastfetch"  "$HOME/.config/fastfetch"
cp -r "$REPO_DIR/nvim"       "$HOME/.config/nvim"
cp    "$REPO_DIR/.zshrc"     "$HOME/.zshrc"

# Wallpapers: hyprlock.conf and waypaper/config.ini both point at
# ~/wallpaper (singular, no dot, directly under $HOME) -- NOT
# ~/.config/... and NOT the repo's own "Wallpapers/" folder name.
# Keep this in sync with those configs if you ever rename either side.
mkdir -p "$HOME/wallpaper"
cp -r "$REPO_DIR/Wallpapers/." "$HOME/wallpaper/"

# --- Scripts need to be executable ---
c_green "==> Setting script permissions"
find "$HOME/.config/hypr/scripts"   -type f -exec chmod +x {} +
find "$HOME/.config/waybar/scripts" -type f -exec chmod +x {} +
find "$HOME/.config/rofi/scripts"   -type f -exec chmod +x {} +
find "$HOME/.config/waypaper" -maxdepth 1 -type f -name "*.sh" -exec chmod +x {} +

# --- Optional: set zsh as default shell ---
if [ "$SHELL" != "$(command -v zsh)" ]; then
    read -rp "Set zsh as your default shell? [y/N] " ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        chsh -s "$(command -v zsh)"
    fi
fi

c_green "==> Done."
echo
c_yellow "A few things this script does NOT do for you:"
echo "  - Log out and back in (or reboot) so Hyprland picks up the Lua config."
echo "  - Open waypaper and pick/apply a wallpaper from ~/wallpaper."
echo "  - Install an AUR helper (paru or yay) if you don't already have one --"
echo "    required for the AUR package list above."
echo "  - Anything specific to your hardware (GPU drivers, laptop-specific"
echo "    keybinds, monitor layout in ~/.config/hypr/monitors.lua)."
if [ -d "$BACKUP_DIR" ] && [ "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]; then
    echo
    c_yellow "Your previous configs were preserved at: $BACKUP_DIR"
fi
