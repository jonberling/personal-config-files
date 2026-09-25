#!/usr/bin/env bash
set -euo pipefail

pushd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null

# Install the bash config into ~/.config/bash
config_dir="$HOME/.config/bash"
mkdir -p "$config_dir"
cp config-files/bashrc "$config_dir/bashrc"

# Add a line to ~/.bashrc that sources the config, if it isn't already there
bashrc="$HOME/.bashrc"
source_line='if [ -f "$HOME/.config/bash/bashrc" ]; then source "$HOME/.config/bash/bashrc"; fi'

touch "$bashrc"

if ! grep -qF "$source_line" "$bashrc"; then
    # Ensure the file ends with a newline before adding the blank line
    [[ -s "$bashrc" && $(tail -c1 "$bashrc") != "" ]] && printf '\n' >> "$bashrc"
    printf '\n%s\n' "$source_line" >> "$bashrc"
fi

echo
echo "Run the following to apply the changes to your current shell:"
echo "  source ~/.bashrc"
