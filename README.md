# Personal Config Files

This repository contains scripts and configuration files to help set up a new Linux system quickly and consistently. Each script is designed to automate the installation and configuration of common tools, shell environments, and network services.

## Scripts Overview

### `init-system-setup.sh`

Automates the initial setup of a new Linux system by installing common packages. It also provides links to download additional software (Chrome, VS Code, etc)

### `setup-git.sh`

Configures git global defaults (user name, email, `init.defaultBranch`, `core.editor`, `pull.rebase`). Run interactively after `init-system-setup.sh`.

### `install-shell-config.sh`

Sets up your shell configuration. Creates `~/.config/shell` for storing shell configuration options. Add custom shell configuration data to `~/.config/shell/shell-config.sh`. It also creates a local git repo so shell configuration changes can be tracked over time.

API keys can be placed in `~/.config/shell/api-keys.sh`. These will not be tracked by git.

## License

See `LICENSE` for details.
