#!/bin/bash

# Start and end numbers for the container names
START=1
END=85

# File to store the final output
OUTPUT_FILE="aggregate_results.csv"

# Array to hold all the counts for each container
declare -a counts
# Array to store the names from the first output file
declare -a names

# Initialize the array with empty strings
for (( i=START; i<=END; i++ )); do
    counts[i]=""
done

# Determine the number of lines (counts) in each output file
FIRST_OUTPUT_FILE="container1/outputs/output_*"
if [ -f $FIRST_OUTPUT_FILE ]; then
    NUM_LINES=$(wc -l < $FIRST_OUTPUT_FILE)

    # Read names from the first output file
    while IFS= read -r line; do
        name=$(echo "$line" | grep -oP '^[^:]+')
        names+=("$name")
    done < $FIRST_OUTPUT_FILE
else
    echo "First output file not found."
    exit 1
fi

# Loop through the container numbers
for (( i=START; i<=END; i++ )); do
    # Define the directory path
    DIRECTORY="container$i/outputs"

    # Check if the directory exists
    if [ -d "$DIRECTORY" ]; then
        # Process each file starting with output_
        for file in "$DIRECTORY"/output_*; do
            # Check if file exists and is not a directory
            if [ -f "$file" ]; then
                line_num=0
                while IFS= read -r line; do
                    ((line_num++))
                    # Extract the number after ': '
                    number=$(echo "$line" | grep -oP '(?<=: )\d+')
                    if [ ! -z "$number" ]; then
                        # Append the number to the array
                        counts[line_num]+="$number, "
                    fi
                done < "$file"
            fi
        done
    fi
done

# Remove the last comma and space from each count string and add the names
for (( j=1; j<=NUM_LINES; j++ )); do
    counts[j]=${counts[j]%, }
    echo "${names[j-1]}, ${counts[j]}" >> "$OUTPUT_FILE"
done