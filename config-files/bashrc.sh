# Begin settings from setup-bash.sh in "personal-config-files" repository

# Set up less to support color and other options
export LESS="-R -F -X $LESS"

# Set up the terminal to support true color
export COLORTERM=truecolor

# Set up common aliases
alias ll='ls -lh --color'

# Add an alias for fd if it is installed as fdfind
if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
    alias fd='fdfind'
fi

# Add commands that cannot be alias's
edit() {
    gedit "$@" >/dev/null 2>&1 &
}

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

# End settings from setup-bash.sh in "personal-config-files" repository
