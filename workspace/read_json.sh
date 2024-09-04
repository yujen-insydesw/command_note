#!/bin/bash

# Main

# raw.json
# {
#     "id": 3,
#     "message": {
#             "id": 333,
#             "string": "raw"
#     }
# }

# use jq
# jq .message.string raw.json

# Check if names is provided as an argument
if [ -z $2 ]; then
    echo "Usage: $0 <.nest.nest...> <json>"
    exit 1
fi

# Extract information
result=$(jq $1 $2)

# Check result
if [ -z $result ]; then
    echo null
else
    echo $result
fi