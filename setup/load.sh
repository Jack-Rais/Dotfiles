#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Uso: $0 -l|-c -h|-s"
    exit 1
fi

case "$2" in
  -h) HYPR=true;;
  -s) HYPR=false;;
  *) echo "Uso: $0 -l|-c [-h|-s]"; exit 1;;
esac



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
if [[ "$HYPR" == true ]]; then 
    
    include_dirs=(

        alacritty
        fontconfig
        gtk-3.0
        hellwal
        hypr
        kitty
        nvim
        waybar
        wofi

        .bashrc
        .bash_profile

    )

else

        include_dirs=(

        alacritty
        fontconfig
        gtk-3.0
        hellwal
        kitty
        nvim
        sway
        waybar
        wofi

        .bashrc
        .bash_profile

    )

fi


for dir_rel in "${include_dirs[@]}"; do
    bash "$origin/setup/scripts/move_dirs.sh" "$origin" "$dest_dir" "$dir_rel" "$1"
done



if [[ "$HYPR" == true ]]; then
    # Setting up wallpaper
    bash "$dest_dir/hypr/scripts/set_wallpaper.sh"
    hyprctl reload

else 
    bash "$dest_dir/sway/scripts/set_wallpaper.sh"
    swaymsg reload
fi

echo "Done"

