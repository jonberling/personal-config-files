#!/usr/bin/env bash

prompt_to_continue() {
    read -n 1 -s -r -p "Press any key to continue..."
}

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

# Use apt-get to install all packages in the array.
# The -y flag automatically answers yes to prompts.
echo "Starting installation of packages..."
sudo apt-get update
sudo apt-get install -y "${packages[@]}"

echo "
Installation of common packages complete.
"

echo "
Installing Microsoft fonts. Accept the EULA when prompted.
"

prompt_to_continue
sudo apt install ttf-mscorefonts-installer

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
