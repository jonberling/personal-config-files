#!/usr/bin/env bash
# Initial system setup script for Ubuntu/Debian systems

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
    python3 python3-pip python-is-python3 \
    zsh \
    openssh-client openssh-server \
    nfs-common \
    snapd \

echo "
Installing Microsoft fonts. Accept the EULA when prompted.
"
sudo apt install ttf-mscorefonts-installer

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
