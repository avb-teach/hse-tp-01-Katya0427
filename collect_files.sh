#!/bin/bash

input_dir=$1
output_dir=$2

if  [[ "$#" -eq 3 ]]
then max_depth=$3
else max_depth=""
fi

if [[ -z "$max_depth" ]]
then find "$input_dir" -type f -exec cp {} "$output_dir" \;
else 
     current_depth=1
     while [[ $current_depth -le $max_depth ]]; do
          for item in "$input_dir"/*; do
             if [[ -d "$item" ]]
             then dir_name=$(basename "$item")
                  mkdir -p "$output_dir/$dir_name"
             elif [[ -f "$item" ]]
             then cp "$item" "$output_dir/"
             fi
             done
          input_dir="$input_dir/*"
          current_depth=$((current_depth + 1))
        done
fi
