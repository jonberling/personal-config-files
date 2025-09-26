#!/usr/bin/env bash
# Install shell configuration files to ~/.config/shell

# Install shell configuration files
mkdir -p ~/.config/shell
cp shell-config/shell-config.sh ~/.config/shell/shell-config.sh
cp shell-config/gitignore ~/.config/shell/.gitignore
touch ~/.config/shell/api-keys.sh
chmod 600 ~/.config/shell/api-keys.sh  # Only current user can access the api-keys.sh file

# Move existing rc files to shell config so changes can be tracked
if [[ -f ~/.bashrc && ! -L ~/.bashrc ]]; then
    mv ~/.bashrc ~/.config/shell/bashrc
    ln -s ~/.config/shell/bashrc ~/.bashrc
fi
if [[ -f ~/.zshrc && ! -L ~/.zshrc ]]; then
    mv ~/.zshrc ~/.config/shell/zshrc
    ln -s ~/.config/shell/zshrc ~/.zshrc
fi

# Make shell config directory a git repo
pushd ~/.config
git init shell
popd

pushd ~/.config/shell
git add .
git commit -m "Install of shell configuration files" || echo "No changes to commit"
popd

# Ensure .bashrc and .zshrc source the new shell config
SOURCE_LINE="source ~/.config/shell/shell-config.sh"

if ! grep -q "$SOURCE_LINE" ~/.bashrc; then
    echo "Adding source line to ~/.bashrc"
    echo -e "\n$SOURCE_LINE" >> ~/.bashrc
fi

if ! grep -q "$SOURCE_LINE" ~/.zshrc; then
    echo "Adding source line to ~/.zshrc"
    echo -e "\n$SOURCE_LINE" >> ~/.zshrc
    echo 'If you are using oh-my-zsh, please move the line to before "source $ZSH/oh-my-zsh.sh"'
fi

# Ensure ~/.local/bin exists
mkdir -p ~/.local/bin

# Final message
cat << EOF
Shell configuration installation complete.

To apply the changes, please restart your terminal or run the following command:
source ~/.config/shell/shell-config.sh
EOF
