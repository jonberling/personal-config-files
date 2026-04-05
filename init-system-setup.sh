#!/usr/bin/env bash
# Initial system setup script for Ubuntu/Debian systems

export DEBIAN_FRONTEND=noninteractive
set -e  # Exit immediately if a command exits with a non-zero status

# Update and upgrade existing packages
sudo apt update -y
sudo apt upgrade -y

echo "Starting installation of packages..."
# install common packages
sudo apt install -y \
    clang gcc g++ cmake \
    git \
    btop htop tree vim \
    wget curl rsync \
    python3 python3-pip python-is-python3 pipx \
    openssh-client openssh-server \
    nfs-common \
    snapd \
    nvidia-cuda-toolkit \
    gedit \

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install Rust - uv must be installed first
if ! command -v rustup >/dev/null; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source ~/.cargo/env
else
    echo "Rust is already installed, skipping."
fi

# Move to a temporary directory for packages that require downloading and installing
tmp_dir=$(mktemp -d)
pushd "$tmp_dir" > /dev/null

# Install mdcat
curl --location --silent https://github.com/swsnr/mdcat/releases/download/mdcat-2.7.1/mdcat-2.7.1-x86_64-unknown-linux-gnu.tar.gz -o mdcat-2.7.1-x86_64-unknown-linux-gnu.tar.gz
tar -xf mdcat-2.7.1-x86_64-unknown-linux-gnu.tar.gz
sudo chmod +x mdcat-2.7.1-x86_64-unknown-linux-gnu/mdcat
sudo cp mdcat-2.7.1-x86_64-unknown-linux-gnu/mdcat /usr/local/bin/mdcat

# We are done with the temporary directory, return to the original directory and remove it
popd > /dev/null
rm -r "$tmp_dir"

# Enable thumbnails on network shares
gsettings set org.gnome.desktop.thumbnailers disable-all false
gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'
nautilus -q

# check if ttf-mscorefonts-installer is installed, if not install it
if ! dpkg -l | grep ttf-mscorefonts-installer >/dev/null; then
    echo -e "\nInstalling Microsoft fonts...\n"

    # Pre-accept the Microsoft fonts EULA
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections

    # Install microsoft fonts
    sudo apt install -y ttf-mscorefonts-installer
fi

# Ensure key home directories exist
mkdir -p $HOME/.local/bin
mkdir -p $HOME/.config
mkdir -p $HOME/.local/share
mkdir -p $HOME/.cache

# Final message
echo -e "\nSystem setup complete.\n"

mdcat download-software.md

echo -e "\nSee README.md for post-setup instructions.\n"
