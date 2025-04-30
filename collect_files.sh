#!/bin/bash

input_dir=$1
output_dir=$2

if  [[ "$#" -eq 3 ]]
then max_depth=$3
else max_depth=""
fi

copy(){
     current_dir=$1
     current_depth=$2
     if [[ "$current_depth" -gt "$max_depth" ]]; then 
          return
     fi
     
     for item in "$current_dir"/*; do
          if [[ -d "$item" ]]
          then copy "$item" $((current_depth + 1))
          elif [[ -f "$item" ]]
          then cp "$item" "$output_dir/$name"
          fi
     done
}                
     
if [[ -z "$max_depth" ]]
then find "$input_dir" -type f -exec cp {} "$output_dir" \;
else copy $input_dir 1
fi
    
