# Personal Config Files

This repository contains scripts and configuration files to help set up a new Linux system quickly and consistently. Each script is designed to automate the installation and configuration of common tools, shell environments, and network services.

## Scripts Overview

### `init-system-setup.sh`

Automates the initial setup of a new Linux system by installing common packages via `apt`. It also provides links to download additional software (Oh My Zsh, Chrome, VS Code)

### `install-shell-config.sh`

Sets up your shell configuration. Creates `~/.config/shell` for storing shell configuration options. Add custom shell configuration data to `~/.config/shell/shell-config.sh`. It also creates a local git repo so shell configuration changes can be tracked over time.

API keys can be placed in `~/.config/shell/api-keys.sh`. These will not be tracked by git.

### `install-samba.sh`

Automates Samba installation for file sharing by updating and upgrading system packages, installing Samba and WSDD, and referring users to a DigitalOcean guide for further configuration steps.

## License

See `LICENSE` for details.
