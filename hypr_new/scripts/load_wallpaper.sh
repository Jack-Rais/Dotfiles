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

if ! command -v jq &>/dev/null; then
    echo "Errore: 'jq' non trovato." >&2
    exit 1
fi


WAL_CACHE="$HOME/.cache/wal/colors.json"
HYPRP_CONFIG="./../hyprpaper.conf"
OUT_DIR="./../../colors"
OUT_CSS_WAY="$OUT_DIR/colors.css"
OUT_CSS_ROFI="$OUT_DIR/colors.rasi"
OUT_HYPRLOCK="$OUT_DIR/colors.conf"

WALLPAPER_DIR="./../wallpapers/"
BASE_WALL_DIR="./../wallpapers/current.jpg"
BASE_WALL_BLUR="./../wallpapers/current_blurred.png"

# Funzione per rimuovere il simbolo '#'
strip_hash() {
    echo "${1#\#}"
}

# === 1. Gestione wallpaper e Hyprpaper ===
if [[ -z $1 ]]; then
    if [[ -f "$BASE_WALL_DIR" && -f "$BASE_WALL_BLUR" ]]; then
        
        wal -i "$BASE_WALL_DIR" -s -t
    
    elif [[ -f "$BASE_WALL_DIR" ]]; then
        
        wal -i "$BASE_WALL_DIR" -s -t
        source ./../scripts/blur_wallpaper.sh "$BASE_WALL_DIR"

    else
        echo "Nessun wallpaper in cache o parametro non valido"
        exit 1
    fi

else
    
    abs_input=$(realpath "$1")
    abs_target=$(realpath "$WALLPAPER_DIR")

    # Clean wallpaper dir
    rm "$abs_target/"*

    if [[ "$abs_input" != "$abs_target/"* ]]; then
        echo "Copio l'immagine in $WALLPAPER_DIR"
        cp "$1" "$WALLPAPER_DIR/"
        new_path="$WALLPAPER_DIR/$(basename "$1")"

    else
        new_path="$1"
    fi

    wal -i "$new_path" -s -t
    source ./../scripts/blur_wallpaper.sh "$BASE_WALL_DIR"

    cat > "$HYPRP_CONFIG" << EOF
preload = $new_path
wallpaper = , $new_path
EOF

    pkill hyprpaper 
    sleep 0.2
    hyprpaper 
fi

# === 2. Estrazione colori ===
readarray -t COLORS < <(
    jq -r '
    .special.background,
    .special.foreground,
    .colors.color0,
    .colors.color1,
    .colors.color2,
    .colors.color3,
    .colors.color4,
    .colors.color5,
    .colors.color6,
    .colors.color7,
    .colors.color8,
    .colors.color9,
    .colors.color10
    ' "$WAL_CACHE"
)

background="${COLORS[0]}"
foreground="${COLORS[1]}"

# === 3. Output colors.css (waybar, GTK, ecc.) ===
{
    echo "@define-color background $background;"
    echo "@define-color foreground $foreground;"
    for i in {0..10}; do
        echo "@define-color color$i ${COLORS[$((i + 2))]};"
    done
} > "$OUT_CSS_WAY"

# === 4. Output colors.rasi (rofi) ===
{
    echo "* {"
    echo "    background: $background;"
    echo "    foreground: $foreground;"
    for i in {0..10}; do
        echo "    color$i: ${COLORS[$((i + 2))]};"
    done
    echo "}"
} > "$OUT_CSS_ROFI"

# === 5. Output colors.conf (hyprlock, in rgba format) ===
{
    echo "\$background = rgba($(strip_hash "$background"))"
    echo "\$foreground = rgba($(strip_hash "$foreground"))"
    for i in {0..10}; do
        hex="${COLORS[$((i + 2))]}"
        echo "\$color$i = rgba($(strip_hash "$hex"))"
    done
} > "$OUT_HYPRLOCK"

