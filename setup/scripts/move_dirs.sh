#!/bin/bash


if [[ $# -lt 4 ]]; then 
    echo "Usage: <origin> <dest> <dir> <link/copy>[-l|\-c]"
    exit 1
fi

case "$4" in
  -l) CMD=(ln -sfn); echo "Linking files";;
  -c) CMD=(cp); echo "Copying files";;
  *) echo "Uso: $0 -l | -c"; exit 1;;
esac

origin="$1"
dest_dir="$2"
dir_rel="$3"


src_dir="$origin/$dir_rel"

if [[ ! -d "$src_dir" && ! -f "$src_dir" ]]; then
    echo "Warning, $src_dir is not a directory or a file"
    exit 1
fi


# Cleaning of destination dir
dest_dir="$dest_dir/$dir_rel"
if [[ -d "$dest_dir" || -f "$dest_dir" ]]; then
    echo "Cleaning occupied destination dir: $dest_dir"
    rm -rf "$dest_dir"
fi


if [[ -f "$src_dir" ]]; then
    
    mkdir -p "$dest_dir"
    echo "Moving: $src_dir -> $dest_dir"

    "${CMD[@]}" "$src_dir" "$dest_dir"

elif [[ -d "$src_dir" ]]; then

    # Find files recursively
    find "$src_dir" -type f | while read -r file; do

        # Relative path + destination
        rel_path="${file#$origin/}"
        final_dest="$dest_dir/$rel_path"

        # Creating destination dir if not present
        mkdir -p "$(dirname "$final_dest")"

        echo "Moving: $file -> $final_dest"
        "${CMD[@]}" "$file" "$final_dest"

    done

fi

