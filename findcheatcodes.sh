#!/bin/bash

# Display usage
if [ $# -ne 1 ]; then
    echo "Usage: $0 <search_directory>"
    exit 1
fi

# Define the file containing the list of cheatcodes
CODE_LIST_FILE="cheatcodes.txt"

# Define the directory to search
SEARCH_DIR="$1"

# Array store for found cheatcodes
declare -a found_codes=()

# Read each cheatcode and search the desired repo for it
while IFS= read -r cheatcode || [ -n "$cheatcode" ]; do
    
    # Skip empty lines
    if [ -z "$cheatcode" ]; then
        continue
    fi

    # Remove any trailing carriage return or whitespace
    cheatcode=$(echo "$cheatcode" | tr -d '\r' | xargs)

    if grep -riq "$cheatcode" "$SEARCH_DIR"; then
        found_codes+=("$cheatcode")
    fi
done < "$CODE_LIST_FILE"

# Output found cheatcodes
echo "Found cheatcodes: "
echo ""
printf '%s\n' "${found_codes[@]}" | sort -u
echo ""
