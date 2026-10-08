# dotfiles — Hyprland en Arch / BlackArch

Copia de seguridad de mi escritorio: Hyprland, la barra, la terminal y el prompt.
Sirve para dejar otra máquina igual que esta.

## Qué hay

| Carpeta | Contenido |
|---|---|
| `config/hypr/` | `hyprland.lua` (ventanas, atajos, autostart) y `hyprlock.conf` (pantalla de bloqueo) |
| `config/waybar/` | Barra superior: `config`, `style.css`, menú de energía (`power.sh`) e IP de la VPN (`vpn.sh`) |
| `config/kitty/` | Terminal: fuente, colores, transparencia, zsh como shell |
| `config/fastfetch/` | Info del sistema con el logo de BlackArch al abrir la terminal |
| `config/starship.toml` | Prompt con iconos y estado del comando anterior |
| `home/` | `.zshrc`, `.bashrc`, `.bash_profile` |
| `wallpaper/` | Fondo de pantalla |
| `packages/` | `pkglist-escritorio.txt` (lo necesario para el escritorio) y `pkglist-completa.txt` (todo lo instalado, incluye herramientas de BlackArch) |
| `system/` | Pantalla de inicio de sesión (greetd + tuigreet): banner BLACKARCH, `greetd-greeter.sh` y `instalar-login.sh` |

## Restaurar en una máquina nueva

Con Arch ya instalado, un usuario con `sudo` e internet:

```bash
sudo pacman -S --needed git github-cli
gh auth login
gh repo clone barArch99/dotfiles
cd dotfiles
./install.sh
```

El script instala los paquetes del escritorio, copia las configuraciones (guardando
las que hubiera en `~/.dotfiles-backup-FECHA`) y pone zsh como shell.

Para instalar además todas las herramientas (nmap, metasploit, burpsuite, etc.) hay
que añadir antes el repo de BlackArch y luego:

```bash
./install.sh --todo
```

### Pasos a mano

- **Inicio de sesión (greetd):** `sudo pacman -S greetd greetd-tuigreet`,
  `sudo ./system/instalar-login.sh` y `sudo systemctl enable greetd`.
- **Gráfica:** `hyprland.lua` trae dos variables para NVIDIA al final
  (`LIBVA_DRIVER_NAME`, `__GLX_VENDOR_LIBRARY_NAME`). En una máquina sin NVIDIA, borrarlas.
  Los drivers (`nvidia-open`, `nvidia-utils`) solo están en la lista completa.

## Guardar cambios

Después de tocar cualquier configuración:

```bash
./actualizar.sh "qué cambié"
```

Copia los archivos actuales al repo, hace commit y los sube.

## Atajos principales

| Atajo | Acción |
|---|---|
| `Super + Enter` | Terminal |
| `Super + D` | Lanzador de aplicaciones |
| `Super + W` | Cerrar ventana |
| `Super + F` | Pantalla completa |
| `Super + 1..0` | Cambiar de escritorio |
| `Super + Shift + 1..0` | Mover ventana a otro escritorio |
| `Super + Shift + S` | Captura de pantalla a `~/Imagenes` |
| `Ctrl + Alt + L` | Bloquear |
