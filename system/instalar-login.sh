#!/usr/bin/env bash
# Instala la pantalla de login (greetd + tuigreet) con el banner BLACKARCH.
# Uso:  sudo ./instalar-login.sh
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

[[ $EUID -eq 0 ]] || { echo "Ejecútalo con sudo."; exit 1; }

echo "==> Instalando la fuente grande de consola (terminus-font)"
pacman -S --needed --noconfirm terminus-font

echo "==> Copiando el greeter a /etc/greetd"
[[ -e /etc/greetd/config.toml.bak ]] || cp -a /etc/greetd/config.toml /etc/greetd/config.toml.bak
install -m 644 "$SRC/greetd-banner.txt"  /etc/greetd/banner.txt
install -m 755 "$SRC/greetd-greeter.sh"  /etc/greetd/greeter.sh
install -m 644 "$SRC/greetd-config.toml" /etc/greetd/config.toml

echo "==> Listo. Cierra sesión o reinicia para verlo."
echo "    Para volver al login anterior: sudo cp /etc/greetd/config.toml.bak /etc/greetd/config.toml"
