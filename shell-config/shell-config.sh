if [[ ! "$LESS" =~ "-R -F -X" ]]; then
  export LESS="-R -F -X $LESS"
fi

alias ll='ls -lh --color'

ZSH_THEME="murilasso"

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

source ~/.config/shell/api-keys.sh
