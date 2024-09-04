#!/bin/bash

function is_exist() {
    if [ -d $1 ]; then
        return 0
    else
        return 1
    fi
}

# Main

# Check if the directory name is provided as an argument
if [ -z $1 ]; then
    echo "Usage: $0 <directory_name>"
    exit 1
fi

# Create the directory
if is_exist $1; then
    echo Already existed $1
    exit 1
else
    mkdir -p $1
fi

# Confirm the directory
if is_exist $1; then
  echo Directory $1 created successfully.
else
  echo Failed to create directory $1.
fi