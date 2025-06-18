
#!/bin/bash

# Verifica numero argomenti
if [ "$#" -ne 2 ]; then
  echo "Uso: $0 <origine> <destinazione>"
  exit 1
fi

origine=$(realpath "$1")
destinazione=$(realpath "$2")

if [ ! -d "$origine" ]; then
  echo "Errore: la directory di origine '$origine' non esiste."
  exit 2
fi

# Crea la directory di destinazione se non esiste
mkdir -p "$destinazione"


find "$origine" -type d -name .git -prune -o -type f -print | while read -r file; do
 
    base="${file##$origine}"
    final_dest="$destinazione$base"
    
    mkdir -p "$(dirname $final_dest)"

    if [[ -f $final_dest ]] then
        echo "existing $final_dest"
        rm "$final_dest"
    fi

    echo "linkando $file a $final_dest"
    ln -s $file $final_dest

done
