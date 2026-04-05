#!/bin/bash

# 1. Define the latest NVM installer version
NVM_VERSION="v0.40.4"

echo "Step 1: Downloading and installing NVM ($NVM_VERSION)..."
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash

# 2. Load NVM into the current shell session script
# This allows the script to use the 'nvm' command immediately without restarting the terminal
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# 3. Verify NVM was installed
if ! command -v nvm &> /dev/null
then
    echo "NVM installation failed. Please check your internet connection or curl installation."
    exit 1
fi

echo "Step 2: Installing the latest stable version of Node.js..."
# 'node' is an alias in nvm for the latest version
nvm install node

echo "Step 3: Setting the latest version as default..."
nvm alias default node
nvm use default

echo "------------------------------------------"
echo "SUCCESS: Node.js and NPM have been installed."
echo "Node version: $(node -v)"
echo "NPM version:  $(npm -v)"
echo "------------------------------------------"
echo "IMPORTANT: To use 'nvm', 'node', or 'npm' in this specific terminal window now,"
echo "run the following command:"
echo "source ~/.bashrc"
