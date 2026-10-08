#!/bin/sh
# Greeter de greetd: banner BLACKARCH grande + fuego frío en cian (tuigreet).
# Lo lanza /etc/greetd/config.toml como usuario "greeter" sobre la tty1.
BANNER="${GREETER_BANNER:-/etc/greetd/banner.txt}"

if [ "$TERM" = linux ]; then
    # Fuente grande de consola (16x32 -> 120x33 en 1080p). Si no está, se queda la de siempre.
    setfont ter-132b 2>/dev/null || true
    # Paleta de la consola igual que hyprlock/waybar: fondo #05070d, cian #00bfff.
    printf '\033]P005070d\033]P40a3d7a\033]P600bfff\033]P7c8d3e0'
    printf '\033]P83a4a5e\033]PC1e90ff\033]PE33d6ff\033]PFe6faff\033[2J\033[H'
fi

exec tuigreet \
    --remember --asterisks \
    --time --time-format '%A %d %B %Y  ·  %H:%M:%S' \
    --greeting "$(cat "$BANNER")" \
    --width 80 --container-padding 2 --prompt-padding 1 \
    --theme 'border=cyan;text=cyan;greet=lightcyan;prompt=lightcyan;input=white;time=lightcyan;action=black;button=lightcyan;container=black' \
    --background doom --doom-colors 'blue,cyan,white' --doom-height 4 \
    --cmd start-hyprland "$@"
