#!/bin/bash

if [[ -z "$1" ]]; then
    swaybg -i "$HOME/.config/sway/wallpaper/current.jpg" -m fill

else 
    swaybg -i "$1" -m fill

fi
