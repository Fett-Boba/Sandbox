#!/bin/bash

# Make sure directory was passed via command line
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Set the directory to command line arg and CD into it
DIR="$1"
cd "$DIR"

# Store names of the directories, read into the array
directories=()
while read -r line; do
    directories+=("$line")
done < <(ls -d */ | sed 's/\/$//')

# Write the opening bracket to the file
echo "[" > tests.json

# Write names of the directories stored in the array to a file
for dir in "${directories[@]}"; do
    echo -e " {\n  \"name\": \"$dir\",\n  \"description\": \"Acct type codes starting with $dir\"\n }," >> tests.json
done

# Write the closing bracket to the file
echo "]" >> tests.json
