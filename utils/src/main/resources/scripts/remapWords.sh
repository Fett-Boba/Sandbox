#!/bin/bash

# Define your list of name-value pairs
declare -A pairs=( ["old_word1"]="new_word1" ["old_word2"]="new_word2" )

# Specify the directory you want to change files in
dir="your_directory"

# Loop over all files in the directory
for file in "$dir"/*
do
  # Check if it is a file not a directory
  if [ -f "$file" ]; then
    # Loop over the pairs and use sed to find and replace
    for i in "${!pairs[@]}"
    do
      sed -i "s/$i/${pairs[$i]}/g" "$file"
    done
  fi
done
