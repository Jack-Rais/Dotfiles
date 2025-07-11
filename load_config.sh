
#!/bin/bash

# Imposta origine come la directory in cui si trova questo script
origine="$(cd "$(dirname "${BASH_SOURCE[0]}")/" && pwd)"
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
	waybar
    gtk-3.0
	nvim
	rofi
	hypr
	scripts
    colors
    fontconfig
    alacritty
)

# Cicla su ciascuna directory della lista
for dir_rel in "${include_dirs[@]}"; do
	src_dir="$origine/$dir_rel"
    
    if [ ! -d "$src_dir" ]; then
		echo "Attenzione: '$src_dir' non è una directory, salto."
		continue
	fi
    
    mv -i "$destinazione/$dir_rel" "$destinazione/$dir_rel.bak"

	# Trova i file dentro solo questa directory
	find "$src_dir" -type f | while read -r file; do
		# Percorso relativo rispetto all'origine
		rel_path="${file#$origine/}"
		final_dest="$destinazione/$rel_path"

		# Crea la directory di destinazione
		mkdir -p "$(dirname "$final_dest")"

		echo "Link: $file -> $final_dest"
		ln -s "$file" "$final_dest"
	done
done


# Ricaricare waybar
pkill waybar
waybar &

# Ricaricare hyprland
hyprctl reload

