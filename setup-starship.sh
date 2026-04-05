#!/usr/bin/env bash
# Install nerd fonts and starship prompt

set -e

tmp_dir=$(mktemp -d)
pushd "$tmp_dir" > /dev/null

# $1: font name as it appears in nerd-fonts releases (e.g. "JetBrainsMono")
# $2: fc-list search string to detect if already installed (e.g. "JetBrainsMono")
install_nerd_font() {
    local name="$1"
    local fc_pattern="$2"
    if ! fc-list | grep "$fc_pattern" >/dev/null; then
        echo "Installing $name..."
        curl --location --silent "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/${name}.zip" -o "${name}.zip"
    else
        echo "$name is already installed, skipping."
    fi
}

# Install popular nerd fonts
install_nerd_font Hack           "Hack Nerd"
install_nerd_font JetBrainsMono  "JetBrainsMono"
install_nerd_font FiraCode       "FiraCode"
install_nerd_font Meslo          "Meslo"
install_nerd_font CascadiaCode   "CascadiaCode"

for zip in *.zip; do
    unzip -q "$zip" -d "${zip%.zip}"
    sudo cp "${zip%.zip}"/*.ttf /usr/local/share/fonts/ 2>/dev/null || true
done
rm *.zip

sudo fc-cache -f  # Update font cache

popd > /dev/null
rm -r "$tmp_dir"

# Set up the default terminal font
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ font 'Hack Nerd Font 12'

# Install starship
echo "Installing starship prompt..."
curl -sS https://starship.rs/install.sh | sh -s -- -y > /dev/null
eval "$(starship init bash)"
