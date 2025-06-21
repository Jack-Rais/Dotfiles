#!/bin/bash

# Avvia rofi in background
rofi -show drun &

# Aspetta un attimo che si apra
sleep 0.2

# Prendi la seconda riga dell'output di hyprctl monitors e la prima parola (es. "1920x1080@60Hz")
INFO=$(hyprctl monitors | sed -n '2p' | awk '{print $1}')

# Prendi la parte prima di '@' (es. "1920x1080")
str=${INFO%@*}

# Dividi la stringa in width e height rispetto a 'x'
IFS='x' read -r width height <<< "$str"

# Calcola il centro
CX=$((width / 2))
CY=$((height / 2))

# Sposta il mouse al centro
hyprctl dispatch movecursor $CX $CY

