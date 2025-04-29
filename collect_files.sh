#!/bin/bash

input_dir=$1
output_dir=$2
if  [[ "$#" -eq 4 ]] && [[ "$3" == "--max_depth" ]]
then max_depth=$4
else max_depth=""
fi

if [[ -z "$max_depth" ]]
then find "$input_dir" -type f -exec cp {} "$output_dir" \;
else find "$input_dir" -maxdepth "$max_depth" -type f -exec cp {} "$output_dir" \;
     find "$input_dir" -maxdepth "$max_depth" -type d -exec cp -r {} "$output_dir" \;
fi
