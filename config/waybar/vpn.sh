#!/usr/bin/env bash
# Muestra la IP de la VPN (tun0, p.ej. Hack The Box) solo cuando está conectada
ip=$(ip -4 -o addr show tun0 2>/dev/null | awk '{print $4}' | cut -d/ -f1)
[[ -n $ip ]] && printf '{"text":"\U000F0582  %s","tooltip":"VPN tun0 — clic para copiar","class":"on"}\n' "$ip" || echo '{"text":""}'
