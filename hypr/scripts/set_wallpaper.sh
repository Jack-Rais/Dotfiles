#!/bin/bash

#                _ _
# __      ____ _| | |_ __   __ _ _ __   ___ _ __
# \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__|
#  \ V  V / (_| | | | |_) | (_| | |_) |  __/ |
#   \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|
#                   |_|         |_|


if ! command -v hellwal &>/dev/null; then
    echo "Errore: 'hellwal' non trovato. Installa hellwal." >&2
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


templates_dir="$base_path/hellwal/templates"
final_dir="$base_path"

for f in "$templates_dir"/*; do
    
    if [[ -L "$f" ]]; then
        echo "$f è un symlink"
        final_dir="$(dirname $(readlink -f $f))"
    fi

done

if [[ "$final_dir" != "$base_path" ]]; then
    
    echo "Symlink trovati, nuovo base path: $final_dir"
fi

HEL_CMD=(hellwal --skip-term-colors --debug -f "$final_dir/")

copy_files() {

    find "$CACHE_DIR" -maxdepth 1 -type f | while read -r file; do
        out_file=$(basename "$file")
        echo "copying file: $file -> $OUT_DIR/$out_file"
        cp "$file" "$OUT_DIR/$out_file"
    done

}


# === 1. Gestione wallpaper e Hyprpaper ===
if [[ -z $1 ]]; then

    if [[ -f "$BASE_WALL_DIR" ]]; then
        
        echo "Found default directory for the wallpaper"
        
        if [[ -d "$CACHE_DIR" ]]; then
            echo "Removing default cache"
            rm -r "$CACHE_DIR"
            mkdir -p "$CACHE_DIR/cache"
        fi

        echo "Running hellwal: ${HEL_CMD[@]}"
        "${HEL_CMD[@]}" -i "$BASE_WALL_DIR"
        
        echo "$base_path"

        echo "Copying files"
        copy_files 

        if [[ ! -f "$BASE_WALL_BLUR" ]]; then
            echo "Blurred wallpaper not found, creating a blurred copy"
            bash "$HOME/.config/hypr/scripts/blur_wallpaper.sh" "$BASE_WALL_DIR"
        else
            echo "Found $BASE_WALL_BLUR, using that image"
        fi
    
    elif [[ ! -d "$CACHE_DIR" ]]; then
        
        echo "Loading saved colors in cache"
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
    
    echo "Running hellwal: ${HEL_CMD[@]}"
    "${HEL_CMD[@]}" -i "$new_path"
    bash "$base_path/hypr/scripts/blur_wallpaper.sh" 

fi


pkill hyprpaper
pkill waybar

hyprctl dispatch exec waybar
hyprctl dispatch exec hyprpaper
