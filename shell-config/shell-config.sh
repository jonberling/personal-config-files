if [[ ! "$LESS" =~ "-R -F -X" ]]; then
  export LESS="-R -F -X $LESS"
fi

COLORTERM=truecolor

alias ll='ls -lh --color'

# Add commands that cannot be alias's
edit() {
    gedit "$@" >/dev/null 2>&1 &
}

# Enable starship prompt
eval "$(starship init bash)"

# Add ~/.local/bin to PATH if it is not already included
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Bash-specific settings
if [[ -n "$BASH_VERSION" ]]; then
    # Binds the Up/Down arrow keys to search through history
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi

# Set XDG base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

source ~/.config/shell/api-keys.sh
