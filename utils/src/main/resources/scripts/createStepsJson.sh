#!/bin/bash

# Check if the directory argument is provided
if [ -z "$1" ]
then
    echo "Please provide a directory as an argument"
    exit 1
fi

# Set the directory and output file variables
DIR="$1"
#OUTPUT_FILE="output.txt"

# Check if the directory exists
if [ ! -d "$DIR" ]
then
    echo "The directory does not exist"
    exit 1
fi

# Check if the directory is empty
if [ -z "$(ls -A "$DIR")" ]
then
    echo "The directory is empty"
    exit 1
fi

# Write the opening bracket to the output file
echo "[" > ".\/$DIR\/output.json"

# Write the output file, excluding any *.json, using the internal field seperator IFS of /
find "$DIR" -type f ! -name "*.json" | while read -r FILE; do
    DIRNAME=$(dirname "$FILE" | sed 's/^\.\///')
    IFS='/' read -ra PARTS <<< "$DIRNAME"
    PART1="${PARTS[0]}"
    PART2="${PARTS[1]}"
    echo -e " {\n  \"desc\": \"$PART2\",\n  \"type\": \"type goes here\",\n  \"source\": \"$PART1\",\n  \"value\": \"/$PART2/$(basename "$FILE")\", \n  \"dt\": \"eee\"\n}," >> ".\/$DIR\/output.json"
done

# Remove the comma on the last line of the output
sed -i '$ s/,$//' ".\/$DIR\/output.json"

# Write the closing bracket to the file
echo "]" >> ".\/$DIR\/output.json"
