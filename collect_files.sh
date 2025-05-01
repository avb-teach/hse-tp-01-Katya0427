#!/bin/bash

input_dir=$1
output_dir=$2
max_depth=""

if [[ "$3" == "--max_depth" ]]; then
  max_depth=$4
  if [[ $max_depth -ne 0 ]]; then
    max_depth=$((max_depth - 1))
  fi
fi


if [[ -z "$max_depth" ]]
then find "$input_dir" -type f -exec cp {} "$output_dir" \;
else
  find "$input_dir" -type f | while read -r file; do
    rel_path=${file#$input_dir/}
    dir_depth=$(echo "$rel_path" | tr -cd '/' | wc -c)
    
    if [ $dir_depth -lt $max_depth ]; then
      target_dir="$output_dir/$(dirname "$rel_path")"
      mkdir -p "$target_dir"
      cp "$file" "$target_dir/"
    else
      filename=$(basename "$rel_path")
      dirpath=$(dirname "$rel_path")
      
      new_path=""
      count=0
      remaining=$max_depth
      
      while [ $remaining -gt 0 ] && [ -n "$dirpath" ] && [ "$dirpath" != "." ]; do
        part=$(basename "$dirpath")
        new_path="/$part$new_path"
        dirpath=$(dirname "$dirpath")
        remaining=$((remaining - 1))
      done
      
      target_dir="$output_dir$new_path"
      mkdir -p "$target_dir"
      
      target_file="$target_dir/$filename"
      if [ -f "$target_file" ]; then
      	first_part=$(basename "$filename")
        name="$first_part"
        count=1
        while [[ -e "$output_dir/$name" ]]; do
            name="${first_part%.*}-$count.${name##*.}"
            count=$((count + 1))
        done
        
        cp "$file" "$target_dir/$name"
      else
        cp "$file" "$target_file"
      fi
    fi
  done
fi
