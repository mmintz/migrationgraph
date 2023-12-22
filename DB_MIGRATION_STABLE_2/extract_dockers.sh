#!/bin/bash

# Start and end numbers for the container names
START=1
END=85

# Define the source path inside the Docker containers
SOURCE_PATH_IN_CONTAINER="/app/outputs"

# Get the current working directory
CURRENT_DIR=$(pwd)

# Loop through the container numbers
for (( i=START; i<=END; i++ ))
do
    # Define the container ID or name
    CONTAINER_ID_OR_NAME="container$i"

    # Define the destination directory in the current working directory
    DESTINATION_DIR="$CURRENT_DIR/container$i"

    # Create the destination directory
    mkdir -p "$DESTINATION_DIR"

    # Copying files from the container to the corresponding directory in the current working directory
    docker cp "$CONTAINER_ID_OR_NAME:$SOURCE_PATH_IN_CONTAINER" "$DESTINATION_DIR"
done