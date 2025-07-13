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

input="$(realpath "$1")"
sigma="${2:-8}"


if [[ ! -f "$input" ]]; then
    echo "Immagine non esistente"
    exit 1
fi


extension="${input##*.}"
nuovo_name="$arrivo_dir/current.jpg"
output="$arrivo_dir/current_blurred.png"
clean=false
working="$nuovo_name"

if [[ "$input" == "$(realpath "$nuovo_name")" ]]; then
    echo "L'immagine è già current.jpg, nessuna copia o conversione necessaria."

else
    extension="${input##*.}"

    # Rimuovi current.jpg se esiste
    if [[ -f "$nuovo_name" ]]; then
        echo "Immagine già presente, rimuovendo"
        rm "$nuovo_name"
    fi

    # Copiare o convertire l'immagine
    echo "Copiando l'immagine nella cartella wallpapers"
    if [[ "${extension,,}" != "jpg" ]]; then
        echo "Convertendo in jpg"
        magick "$input" "$nuovo_name"
    else
        cp "$input" "$nuovo_name"
    fi
fi


echo "Conversione in png media"
arrivo="$arrivo_dir/medium.png"
clean=true

if [[ -f "$arrivo" ]]; then
    echo "Immagine media già presente, rimuovendo"
    rm "$arrivo"
fi

magick "$nuovo_name" "$arrivo"
working="$arrivo"


# Sfuocare l'immagine
echo "Applicando la sfumatura"
magick "$working" -blur 0x"$sigma" "$output"


if [[ "$clean" == true ]]; then
    echo "Pulendo l'immagine media"
    rm "$working"
fi
