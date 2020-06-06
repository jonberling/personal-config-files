#!/usr/bin/env bash

# update and upgrade system
sudo apt update -y
sudo apt upgrade -y

# install common packages
sudo apt install -y \
clang gcc g++ \
git cmake \
htop tree vim \
wget curl \
python python3 python3-pip \
zsh \

# install Oh My Zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# install openconnect
# sudo apt-get install network-manager-openconnect network-manager-openconnect-gnome
