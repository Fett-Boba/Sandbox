#!/bin/bash

# Define your list of name-value pairs
declare -A pairs=( ["old_word1"]="new_word1" ["old_word2"]="new_word2" )

# Specify the directory you want to change files in
dir="$1"

# Prepare the awk command
awk_cmd='{'
for i in "${!pairs[@]}"
do
  awk_cmd+="gsub(/$i/, \"${pairs[$i]}\");"
done
awk_cmd+='print}'

# Loop over all files in the directory
for file in "$dir"/*
do
  # Check if it is a file not a directory
  if [ -f "$file" ]; then
    # Use awk to find and replace
    awk "$awk_cmd" "$file" > temp && mv temp "$file"
  fi
done