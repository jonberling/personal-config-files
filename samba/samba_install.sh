#!/usr/bin/env bash

# update and upgrade system
sudo apt update -y
sudo apt upgrade -y

# install common packages
sudo apt install -y \
samba wsdd

# Follow the guide at:
# https://www.digitalocean.com/community/tutorials/how-to-set-up-a-samba-share-for-a-small-organization-on-ubuntu-16-04
