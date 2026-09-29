#!/usr/bin/env bash
# Configure a DNS search domain on a NetworkManager connection
#
# Example inputs:
#   Connection name:   "Wired connection 1" (NetworkManager's default name for
#                      the first ethernet port) or a Wi-Fi network's name, e.g.
#                      "MyHomeWiFi"
#   DNS search domain: "home.arpa" (the domain reserved for home networks by
#                      RFC 8375), so "nas" resolves as "nas.home.arpa"

set -euo pipefail

echo "Available NetworkManager connections:"
nmcli connection show

echo
read -r -p "Enter a connection name from the above list: " connection_name

if [[ -z "$connection_name" ]]; then
    echo "A connection name is required." >&2
    exit 1
fi

read -r -p "Enter the DNS search domain: " dns_search_domain

if [[ -z "$dns_search_domain" ]]; then
    echo "A DNS search domain is required." >&2
    exit 1
fi

# Only modify the connection if the search domain isn't already set
current_search=$(nmcli --get-values ipv4.dns-search connection show "$connection_name")

if [[ ",$current_search," != *",$dns_search_domain,"* ]]; then
    echo "Setting DNS search domain to $dns_search_domain on $connection_name..."
    sudo nmcli connection modify "$connection_name" ipv4.dns-search "$dns_search_domain"
    sudo nmcli connection up "$connection_name"
else
    echo "DNS search domain $dns_search_domain already configured on $connection_name, skipping."
fi

echo
echo "DNS search domain setup complete."
