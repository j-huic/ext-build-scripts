#!/bin/bash

set -e

# CHANGE ACCORDINGLY
BUILD_DIR="build" # relative path to build directory
BASE_NAME="" # desired name of resulting build file (w/o file extension)
IGNORE_FILE=".buildignore" # format equivalent to .gitignore

mkdir -p "$BUILD_DIR"

if [ ! -f "$IGNORE_FILE" ]; then
    echo "Ignore file not found."
    exit 1
fi

process_ignore_patterns() {
    while IFS= read -r line || [[ -n "$line" ]]; do
        [[ -z "$line" || "$line" == \#* ]] && continue
        
        if [[ "$line" == */ ]]; then
            echo -n " -x \"$line*\""
        else
            echo -n " -x \"$line\""
        fi
    done < "$IGNORE_FILE"
}

IGNORE_PATTERNS=$(process_ignore_patterns)

COUNTER=1
OUTPUT_FILE="$BUILD_DIR/${BASE_NAME}.zip"
while [ -f "$OUTPUT_FILE" ]; do
    OUTPUT_FILE="$BUILD_DIR/${BASE_NAME}_$COUNTER.zip"
    ((COUNTER++))
done

cp manifest_chrome.json manifest.json

# Construct and execute the zip command
ZIP_COMMAND="zip -1 -r \"$OUTPUT_FILE\" . $IGNORE_PATTERNS"
echo "Executing: $ZIP_COMMAND"
eval $ZIP_COMMAND

if [ $? -eq 0 ]; then
    echo "Extension zipped successfully into $OUTPUT_FILE"
    echo "File size: $(du -h "$OUTPUT_FILE" | cut -f1)"
else
    echo "An error occurred while zipping the extension."
    exit 1
fi