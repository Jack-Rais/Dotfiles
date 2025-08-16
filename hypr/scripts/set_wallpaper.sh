#!/bin/bash

#                _ _
# __      ____ _| | |_ __   __ _ _ __   ___ _ __
# \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__|
#  \ V  V / (_| | | | |_) | (_| | |_) |  __/ |
#   \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|
#                   |_|         |_|


if ! command -v wal &>/dev/null; then
    echo "Errore: 'wal' non trovato. Installa pywal." >&2
    exit 1
fi


CACHE_DIR="$HOME/.cache/hellwal/"

mkdir -p "$CACHE_DIR/cache"

script_path="$0"
script_dir="$(dirname "$script_path")"
base_path="$(realpath "$script_dir/../../")"

OUT_DIR="$base_path/colors"
mkdir -p "$OUT_DIR"

WALLPAPER_DIR="$base_path/hypr/wallpapers"
BASE_WALL_DIR="$WALLPAPER_DIR/current.jpg"
BASE_WALL_BLUR="$WALLPAPER_DIR/current_blurred.png"

HEL_CMD=(hellwal --skip-term-colors --debug -f "$HOME/.config/hellwal/templates/")

copy_files() {

    find "$CACHE_DIR" -type f | while read -r file; do
        cp "$file" "$OUT_DIR"
    done

}


# === 1. Gestione wallpaper e Hyprpaper ===
if [[ -z $1 ]]; then

    if [[ -f "$BASE_WALL_DIR" ]]; then
        
        if [[ ! -d "$CACHE_DIR" ]]; then
            echo "Cache dir not found, running hellwal on saved wallpaper"
            "${HEL_CMD[@]}" -i "$BASE_WALL_DIR"
        fi

        copy_files 

        if [[ ! -f "$BASE_WALL_BLUR" ]]; then
            echo "Blurred wallpaper not found, creating a blurred copy"
            source "$HOME/.config/hypr/scripts/blur_wallpaper.sh" "$BASE_WALL_DIR"
        fi
    
    elif [[ ! -d "$CACHE_DIR" ]]; then
        
        echo "Loading saved wallpaper in cache"
        copy_files 

    else
        
        echo "Not found any saved colors or wallpaper"
        exit 1

    fi

else
    
    abs_input=$(realpath "$1")
    abs_target="$WALLPAPER_DIR"


    if [[ "$abs_input" != "$abs_target/"* ]]; then
        
        # Clean wallpaper dir
        rm "$abs_target/"*

        echo "Copio l'immagine in $WALLPAPER_DIR/current.jpg"
        magick "$1" "$WALLPAPER_DIR/current.jpg"
        new_path="$WALLPAPER_DIR/current.jpg"

    else
        new_path="$1"
    fi
    
    echo "Impostando il nuovo wallpaper con wal"
    "${HEL_CMD[@]}" -i "$new_path"
    source "$base_path/hypr/scripts/blur_wallpaper.sh" 

fi

