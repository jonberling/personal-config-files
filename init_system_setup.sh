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
python3 python3-pip python-is-python3 \
zsh \
openssh-client openssh-server \
nfs-common \
