#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Uso: $0 -l|-c"
    exit 1
fi


if [[ "$1" = "-l" ]]; then
    echo "Linking files"
    CMD=(ln -sfn)

elif [[ "$1" = "-c" ]]; then
    echo "Copying files"
    CMD=(cp)

else
    echo "Uso: $0 -l | -c"
    exit 1

fi

# Imposta origine come la directory in cui si trova questo script
origine="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
destinazione="$HOME/.config"

echo "Origine: $origine"
echo "Destinazione: $destinazione"

# Verifica che la directory di origine esista (per sicurezza)
if [ ! -d "$origine" ]; then
    echo "Errore: la directory di origine '$origine' non esiste."
    exit 1
fi

# Crea la directory di destinazione se non esiste
mkdir -p "$destinazione"


# === LISTA DI DIRECTORY DA INCLUDERE (relative alla dir dello script) ===
include_dirs=(

    alacritty
    colors
    fontconfig
    gtk-3
    hellwal
    hypr
    matugen
    nvim
    kitty
    swaync
    waybar
    wofi

)

# Cicla su ciascuna directory della lista
for dir_rel in "${include_dirs[@]}"; do
    src_dir="$origine/$dir_rel"

    if [ ! -d "$src_dir" ]; then
        echo "Attenzione: '$src_dir' non è una directory, salto."
        continue
    fi

    # Pulizia della directory di arrivo corrispondente
    dest_dir="$destinazione/$dir_rel"
    if [ -d "$dest_dir" ]; then
        echo "Pulizia di: $dest_dir"
        rm -rf "$dest_dir"
    fi

    # Trova i file dentro solo questa directory
    find "$src_dir" -type f | while read -r file; do
    # Percorso relativo rispetto all'origine
    rel_path="${file#$origine/}"
    final_dest="$destinazione/$rel_path"

        # Crea la directory di destinazione
        mkdir -p "$(dirname "$final_dest")"

        echo "Moving: $file -> $final_dest"
        "${CMD[@]}" "$file" "$final_dest"
    done
done


config_files=(
    .bashrc
    .bash_profile
)

for dir_rel in "${config_files[@]}"; do
    src_file="$origine/$dir_rel"

    if [ ! -f "$src_file" ]; then
        echo "Attenzione: '$src_file' non è un file, salto."
        continue
    fi

    # Pulizia della directory di arrivo corrispondente
    dest_dir="$HOME/$dir_rel"
    if [ -f "$dest_dir" ]; then
        echo "Pulizia di: $dest_dir"
        rm "$dest_dir"
    fi


    echo "Link: $src_file -> $dest_dir"
    "${CMD[@]}" "$src_file" "$dest_dir"

done

# Ricaricare waybar
pkill waybar
nohup waybar > /dev/null 2>&1 &

# Ricaricare hyprland
hyprctl reload

bash ~/.config/hypr/scripts/load_wallpaper.sh


magick "~/.config/hypr/wallpapers/current.jpg" "~/.config/hypr/wallpapers/median.jpg"
rm "~/.config/hypr/wallpapers/current.jpg"
mv "~/.config/hypr/wallpapers/median.jpg" "~/.config/hypr/wallpapers/current.jpg"
hyprpaper &

echo "Done"

