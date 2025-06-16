#!/bin/bash

WAL_CACHE="$HOME/.cache/wal/colors.json"
HYPRP_CONFIG="$HOME/.config/hypr/hyprpaper.conf"

if [[ -z $1 && -f "$WAL_CACHE" ]]; then
    wal -Rst
elif [[ -z $1 ]]; then
    echo "nessun wallpaper in cache o parametro non valido"
    exit 1
else
    wal -i "$1" -s -t
    cat > "$HYPRP_CONFIG" << EOF

preload = $1
wallpaper = , $1

EOF

    pkill hyprpaper 
    sleep 0.2
    hyprpaper &
    

fi

WAL_COLORS="$WAL_CACHE"
OUT_CSS="$HOME/.config/waybar/colors.css"

background=$(jq -r '.special.background' < "$WAL_COLORS")
foreground=$(jq -r '.special.foreground' < "$WAL_COLORS")
color0=$(jq -r '.colors.color0' < "$WAL_COLORS")
color1=$(jq -r '.colors.color1' < "$WAL_COLORS")
color2=$(jq -r '.colors.color2' < "$WAL_COLORS")
color3=$(jq -r '.colors.color3' < "$WAL_COLORS")
color4=$(jq -r '.colors.color4' < "$WAL_COLORS")
color5=$(jq -r '.colors.color5' < "$WAL_COLORS")
color6=$(jq -r '.colors.color6' < "$WAL_COLORS")
color7=$(jq -r '.colors.color7' < "$WAL_COLORS")
color8=$(jq -r '.colors.color8' < "$WAL_COLORS")
color9=$(jq -r '.colors.color9' < "$WAL_COLORS")
color10=$(jq -r '.colors.color10' < "$WAL_COLORS")

cat > "$OUT_CSS" << EOF
@define-color background $background;
@define-color foreground $foreground;

@define-color color0 $color0;
@define-color color1 $color1;
@define-color color2 $color2;
@define-color color3 $color3;
@define-color color4 $color4;
@define-color color5 $color5;
@define-color color6 $color6;
@define-color color7 $color7;
@define-color color8 $color8;
@define-color color9 $color9;
@define-color color10 $color10;
EOF

pkill waybar
sleep 0.2
waybar &
