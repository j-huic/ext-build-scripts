#!/bin/bash

source config.txt

process_ignore_patterns() {
    while IFS= read -r line || [[ -n "$line" ]]; do
        [[ -z "$line" || "$line" == \#* ]] && continue
        
        if [[ "$line" == */ ]]; then
            echo -n " \"$line*\""
        else
            echo -n " \"$line\""
        fi
    done < "$IGNORE_FILE"
}

cp manifest_firefox.json manifest.json

LINT_COMMAND="web-ext lint --ignore-files $(process_ignore_patterns)"

eval $LINT_COMMAND

cp manifest_chrome.json manifest.json