#!/usr/bin/env bash
# Restaura el escritorio Hyprland de ecorp en una máquina Arch nueva.
# Uso:  ./install.sh            (paquetes del escritorio + configuraciones)
#       ./install.sh --todo     (además instala la lista completa, requiere repo BlackArch)
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

echo "==> Instalando paquetes del escritorio"
sudo pacman -S --needed - < "$REPO/packages/pkglist-escritorio.txt"

if [[ "${1:-}" == "--todo" ]]; then
    if ! grep -q '^\[blackarch\]' /etc/pacman.conf; then
        echo "!! Falta el repo BlackArch. Instálalo primero: https://blackarch.org/downloads.html#install-repo"
        exit 1
    fi
    echo "==> Instalando la lista completa de paquetes"
    sudo pacman -S --needed - < "$REPO/packages/pkglist-completa.txt"
fi

# Copia un archivo guardando antes una copia del que hubiera
put() {
    local src="$1" dst="$2"
    if [[ -e "$dst" ]]; then
        mkdir -p "$BACKUP/$(dirname "${dst#"$HOME"/}")"
        cp -a "$dst" "$BACKUP/${dst#"$HOME"/}"
    fi
    mkdir -p "$(dirname "$dst")"
    cp -a "$src" "$dst"
}

echo "==> Copiando configuraciones"
for f in hypr/hyprland.lua hypr/hyprlock.conf kitty/kitty.conf \
         waybar/config waybar/style.css waybar/power.sh waybar/vpn.sh \
         fastfetch/config.jsonc fastfetch/logo.png starship.toml; do
    put "$REPO/config/$f" "$HOME/.config/$f"
done
chmod +x "$HOME/.config/waybar/power.sh" "$HOME/.config/waybar/vpn.sh"

for f in .zshrc .bashrc .bash_profile; do
    put "$REPO/home/$f" "$HOME/$f"
done

put "$REPO/wallpaper/wallpaper.png" "$HOME/Pictures/wallpaper.png"
mkdir -p "$HOME/Imagenes"

if [[ "$(getent passwd "$USER" | cut -d: -f7)" != "/usr/bin/zsh" ]]; then
    echo "==> Poniendo zsh como shell por defecto"
    chsh -s /usr/bin/zsh
fi

[[ -d "$BACKUP" ]] && echo "==> Tus archivos anteriores quedaron en $BACKUP"
echo "==> Listo. Cierra sesión y entra en Hyprland."
