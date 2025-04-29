#!/bin/bash

input_dir=$1
output_dir=$2
if  [[ "$#" -eq 4 ]] && [[ "$3" == "--max_depth" ]]
then max_depth=$4
else max_depth=""
fi
