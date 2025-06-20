#!/bin/bash

# Set your folder paths
FOLDER1="$1"
FOLDER2="$2"

if [[ ! -d "$FOLDER1" || ! -d "$FOLDER2" ]]; then
  echo "Usage: $0 <folder1> <folder2>"
  exit 1
fi

# Create temporary files in the current directory
FILES1="$(mktemp ./files1.XXXXXX.txt)"
FILES2="$(mktemp ./files2.XXXXXX.txt)"

# Extract and sort base file names
find "$FOLDER1" -type f -exec basename {} \; | sort | uniq > "$FILES1"
find "$FOLDER2" -type f -exec basename {} \; | sort | uniq > "$FILES2"

# Show duplicates
echo "Duplicate file names:"
comm -12 "$FILES1" "$FILES2"

# Clean up
rm -f "$FILES1" "$FILES2"