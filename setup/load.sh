#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Uso: $0 -l|-c"
    exit 1
fi


# Imposta origine come la directory in cui si trova questo script
origin="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
dest_dir="$HOME/.config"

echo "Origin: $origin"
echo "Dest: $dest_dir"

# Verifica che la directory di origine esista (per sicurezza)
if [ ! -d "$origin" ]; then
    echo "Errore: la directory di origine '$origin' non esiste."
    exit 1
fi

# Crea la directory di destinazione se non esiste
mkdir -p "$dest_dir"


# === LISTA DI DIRECTORY O FILES DA INCLUDERE (relative alla dir dello script) ===
include_dirs=(

    alacritty
    colors
    fontconfig
    gtk-3
    hellwal
    hypr
    kitty
    nvim
    swaync
    waybar
    wofi
    
    .bashrc
    .bash_profile

)

for dir_rel in "${include_dirs[@]}"; do
    source ./scripts/move_dirs.sh "$origin" "$dest_dir" "$dir_rel" "$1"
done


# Cleaning nvim cache
source ./scripts/reload_nvim.sh

# Setting up wallpaper
source ./../hypr/scripts/set_wallpaper.sh

# Reload waybar and hyprpaper
pkill waybar && hyprctl dispatch waybar
pkill hyprpaper && hyprctl dispatch hyprpaper

hyprctl reload
echo "Done"

