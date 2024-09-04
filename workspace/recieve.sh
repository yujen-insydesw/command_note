#!/bin/bash

# Function to check if input is a number
is_number() {
    if [[ $1 =~ ^[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to check if input contains specific content
contains_content() {
    if [[ $1 == *"$2"* ]]; then
        return 0
    else
        return 1
    fi
}

# Main script

# Command
# ./recieve.sh 3
# ./recieve.sh hello world
# ./recieve.sh 3 "say hello world"

# Run with interactive way:
#read -p "Enter a value: " input

# Run with value assigned:
input=$1
# Count the number of additional arguments
args=("$@")
echo Number arguments: ${#args[@]}
echo ${args[@]}
echo ""

# Check if the input is a number
if is_number "$input"; then
    echo "The input is a number."
else
    echo "The input is not a number."
fi

# Check if the input contains the word 'hello'
if contains_content "$input" "hello"; then
    echo "The input contains 'hello'."
else
    echo "The input does not contain 'hello'."
fi
