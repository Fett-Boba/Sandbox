#!/bin/bash

# Create the tests.json file.
# $1 = the directory

# Make sure directory was passed via command line
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Set the directory to command line arg and CD into it
DIR="$1"
cd "$DIR"

# Store names of the directories in array
directories=()
while read -r line; do
    directories+=("$line")
done < <(ls -d */ | sed 's/\/$//')

# Write the opening bracket to the output file
echo "[" > tests.json

# Write out the json (no trailing comma for last directory)
counter=0
for dir in "${directories[@]}"; do
  if [[ ! $counter -eq $((${#directories[@]}-1)) ]]; then
      echo -e " {\n  \"name\": \"$dir\",\n  \"description\": \"Acct type codes starting with $dir\"\n }," >> tests.json
  else
      echo -e " {\n  \"name\": \"$dir\",\n  \"description\": \"Acct type codes starting with $dir\"\n }" >> tests.json
  fi
  ((counter++))
done

# Write the closing bracket to the file
echo "]" >> tests.json
