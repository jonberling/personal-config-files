#!/usr/bin/env bash

# Script to set up a new Ubuntu system with common packages and configurations

# Function to prompt user to continue
prompt_to_continue() {
    read -n 1 -s -r -p "Press any key to continue..."
}

# Save the inotify configuration in a variable
inotify_conf="
# Increase max user watches for file watchers (e.g. in VS Code)
fs.inotify.max_user_watches=524288
"

# update and upgrade system
sudo apt update -y
sudo apt upgrade -y

# install common packages
sudo apt install -y \
    clang gcc g++ cmake \
    git \
    btop htop tree vim \
    wget curl \
    python3 python3-pip python-is-python3 \
    zsh \
    openssh-client openssh-server \
    nfs-common \
    network-manager-openconnect-gnome \

echo "
Installation of common packages complete.
"

echo "Adding inotify configuration to /etc/sysctl.conf
"

# increase max user watches for file watchers (e.g. in VS Code)
if ! grep -q "fs.inotify.max_user_watches" /etc/sysctl.conf; then
    echo "$inotify_conf" | sudo tee -a /etc/sysctl.conf > /dev/null
    sudo sysctl -p
fi

echo "Installing Microsoft fonts. Accept the EULA when prompted.
"

prompt_to_continue
sudo apt install ttf-mscorefonts-installer

echo "
Installing uv
"
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "
Installation complete.
"

cat << EOF
Links to download other software:

    Oh My Zsh
    https://ohmyz.sh/#install

    Chrome
    https://www.google.com/chrome/?platform=linux

    VS Code
    https://code.visualstudio.com/download

    Docker
    https://docs.docker.com/engine/install/ubuntu/

    Nvidia Docker
    https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#with-apt-ubuntu-debian
EOF
