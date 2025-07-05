#!/bin/bash
set -euo pipefail

# Controlla se ImageMagick è disponibile
if ! command -v magick &>/dev/null && ! command -v convert &>/dev/null; then
    echo "Errore: ImageMagick (magick/convert) non trovato." >&2
    exit 1
fi
IM_CMD=$(command -v magick || command -v convert)

# Parametri
input="$1"
sigma="${2:-8}"    # intensità della sfocatura (default: 8)

if [[ ! -f "$input" ]]; then
    echo "File non trovato: $input" >&2
    exit 1
fi

# Estrai estensione e percorso di output
extension="${input##*.}"
base="${input%.*}"
output="${base}_blurred.png"
clean=false

# Converti in PNG se necessario
if [[ "${extension,,}" != "png" ]]; then
    echo "Conversione in PNG..."
    "$IM_CMD" "$input" "${base}.png"
    working="${base}.png"
    clean=true
else
    working="$input"
fi

# Applica sfocatura
echo "Applico sfocatura sigma=${sigma}..."
"$IM_CMD" "$working" -blur 0x"$sigma" "$output"

if [[ "$clean" == true ]]; then
    rm "$working"
fi


echo
echo "✅ Operazione completata:"
echo "   Input:     $input"
echo "   Output:    $output"

