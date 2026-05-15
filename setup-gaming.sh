#!/usr/bin/env bash
# Configure gaming defaults and kernel modules

set -e

echo "Configuring ntsync for improved wine/proton performance..."

# 1. Load the module immediately
if ! lsmod | grep -q "^ntsync"; then
    echo "Loading ntsync kernel module..."
    sudo modprobe ntsync
else
    echo "ntsync module already loaded."
fi

# 2. Ensure it loads on boot
if [ ! -f /etc/modules-load.d/ntsync.conf ] || ! grep -q "ntsync" /etc/modules-load.d/ntsync.conf; then
    echo "Setting up persistence for ntsync..."
    echo "ntsync" | sudo tee /etc/modules-load.d/ntsync.conf > /dev/null
else
    echo "ntsync persistence already configured."
fi

echo "Gaming configuration complete."
