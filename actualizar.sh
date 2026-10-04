#!/usr/bin/env bash
# Copia las configuraciones actuales de esta máquina al repo y las sube a GitHub.
# Uso:  ./actualizar.sh "mensaje del cambio"
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for f in hypr/hyprland.lua hypr/hyprlock.conf kitty/kitty.conf \
         waybar/config waybar/style.css waybar/power.sh waybar/vpn.sh \
         fastfetch/config.jsonc fastfetch/logo.png starship.toml; do
    cp -a "$HOME/.config/$f" "$REPO/config/$f"
done
for f in .zshrc .bashrc .bash_profile; do
    cp -a "$HOME/$f" "$REPO/home/$f"
done
cp -a "$HOME/Pictures/wallpaper.png" "$REPO/wallpaper/wallpaper.png"
pacman -Qqen > "$REPO/packages/pkglist-completa.txt"

cd "$REPO"
git add -A
git commit -m "${1:-Actualizar configuraciones}" || { echo "No hay cambios."; exit 0; }
git push
