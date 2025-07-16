#!/bin/bash

script_path="$0"
script_dir="$(dirname "$script_path")"

arrivo_dir="$(realpath "$script_dir/../wallpapers")"

if [[ ! -d "$arrivo_dir" ]]; then 
    echo "La direcory di arrivo non esiste"
    exit 1
fi

# Controlla se ImageMagick è disponibile
if ! command -v magick &>/dev/null; then
    echo "ImageMagick non trovato"
    exit 1
fi

sigma="${1:-8}"


input="$arrivo_dir/current.jpg"
output="$arrivo_dir/current_blurred.png"

echo "Conversione in png media"
media="$arrivo_dir/medium.png"

if [[ -f "$media" ]]; then
    echo "Immagine media già presente, rimuovendo"
    rm "$media"
fi

magick "$input" "$media"


if [[ -f "$output" ]]; then
    echo "Pulendo $output"
    rm "$output"
fi

# Sfuocare l'immagine
echo "Applicando la sfumatura"
magick "$media" -blur 0x"$sigma" "$output"

echo "Pulendo l'immagine media"
rm "$media"
