#!/usr/bin/env bash
# Initial system setup script for Ubuntu/Debian systems

set -e  # Exit immediately if a command exits with a non-zero status

# Add go-lang PPA
echo "Adding PPA repositories."
sudo add-apt-repository --yes ppa:longsleep/golang-backports

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
    golang-go \
    nvidia-cuda-toolkit \

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

# Install popular nerd fonts
if ! fc-list | grep "Hack Nerd" >/dev/null; then
    echo "Installing Hack Nerd Font..."
    curl --location --silent https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip -o Hack.zip
else
    echo "Hack Nerd Font is already installed, skipping."
fi

if ! fc-list | grep "JetBrainsMono" >/dev/null; then
    echo "Installing JetBrainsMono..."
    curl --location --silent https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip -o JetBrainsMono.zip
else
    echo "JetBrainsMono is already installed, skipping."
fi

if ! fc-list | grep "FiraCode" >/dev/null; then
    echo "Installing FiraCode..."
    curl --location --silent https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip -o FiraCode.zip
else
    echo "FiraCode is already installed, skipping."
fi

if ! fc-list | grep "Meslo" >/dev/null; then
    echo "Installing Meslo..."
    curl --location --silent https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip -o Meslo.zip
else
    echo "Meslo is already installed, skipping."
fi

if ! fc-list | grep "CascadiaCode" >/dev/null; then
    echo "Installing CascadiaCode..."
    curl --location --silent https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaCode.zip -o CascadiaCode.zip
else
    echo "CascadiaCode is already installed, skipping."
fi

for zip in *.zip; do
    unzip -q "$zip" -d "${zip%.zip}"
    sudo cp "${zip%.zip}"/*.ttf /usr/local/share/fonts/ 2>/dev/null || true
done
rm *.zip

sudo fc-cache -f  # Update font cache

# Install mdcat
curl --location --silent https://github.com/swsnr/mdcat/releases/download/mdcat-2.7.1/mdcat-2.7.1-x86_64-unknown-linux-gnu.tar.gz -o mdcat-2.7.1-x86_64-unknown-linux-gnu.tar.gz
tar -xf mdcat-2.7.1-x86_64-unknown-linux-gnu.tar.gz
sudo chmod +x mdcat-2.7.1-x86_64-unknown-linux-gnu/mdcat
sudo cp mdcat-2.7.1-x86_64-unknown-linux-gnu/mdcat /usr/local/bin/mdcat

# We are done with the temporary directory, return to the original directory and remove it
popd > /dev/null
rm -r "$tmp_dir"

# Set up the default font
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ font 'Hack Nerd Font 12'

# Install starship
echo "Installing starship prompt..."
curl -sS https://starship.rs/install.sh | sh -s -- -y > /dev/null
eval "$(starship init bash)"

# Configure git defaults
if ! git config --global user.name >/dev/null; then
    read -p "Enter your full name: " REPLY
    git config --global user.name "$REPLY"
fi

if ! git config --global user.email >/dev/null; then
    read -p "Enter your email address: " REPLY
    git config --global user.email "$REPLY"
fi

if ! git config --global init.defaultBranch >/dev/null; then
    git config --global init.defaultBranch main
fi

if ! git config --global core.editor >/dev/null; then
    git config --global core.editor vim
fi

# check if ttf-mscorefonts-installer is installed, if not install it
if ! dpkg -l | grep ttf-mscorefonts-installer >/dev/null; then
    echo -e "\nInstalling Microsoft fonts. Accept the EULA when prompted.\n"
    sudo apt install ttf-mscorefonts-installer
fi

cat << EOF

Links to download other software:

    Chrome
    https://www.google.com/chrome/?platform=linux

    VS Code
    https://code.visualstudio.com/download

    Docker
    https://docs.docker.com/engine/install/ubuntu/

    Nvidia Docker
    https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#with-apt-ubuntu-debian
EOF

cat << EOF
System setup complete.

run ./install-shell-config.sh to set up shell configuration files and apply changes.
EOF
