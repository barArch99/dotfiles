#!/usr/bin/env bash
# Menú de energía para waybar (usa wofi)
choice=$(printf 'Bloquear\nCerrar sesión\nSuspender\nReiniciar\nApagar' | wofi --dmenu --prompt "Energía" --width 260 --height 260 --cache-file /dev/null)
case "$choice" in
    Bloquear)        hyprlock ;;
    "Cerrar sesión") hyprctl dispatch 'hl.dsp.exit()' ;;
    Suspender)       systemctl suspend ;;
    Reiniciar)       systemctl reboot ;;
    Apagar)          systemctl poweroff ;;
esac
