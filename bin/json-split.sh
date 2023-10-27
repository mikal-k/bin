#!/bin/bash

# Get the name of the JSON file to split.
file_name=$1

# Get the total number of lines in the JSON file.
total_lines=$(jq -c '. | length' "$file_name")

# Calculate the approximate number of lines per split.
lines_per_split=$((total_lines / 5))

# Loop to split the JSON file using jq and save each split to a separate file.
for ((index = 0; index < 5; index++)); do
  start_line=$((index * lines_per_split))
  end_line=$((start_line + lines_per_split - 1))

  jq -c ".[$start_line:$end_line]" "$file_name" > "$file_name.$(printf "%02d" $index).json"
  echo "Created $file_name.$(printf "%02d" $index).json"
done

