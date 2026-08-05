# Personal Config Files

This repository contains scripts and configuration files to help set up a new Linux system quickly and consistently. Each script is designed to automate the installation and configuration of common tools, shell environments, and network services.

## Scripts Overview

### `init-system-setup.sh`

Automates the initial setup of a new Linux system by installing common packages, plus Rust, `uv`, and `mdcat`. It also displays links to download additional software (Chrome, VS Code, etc) not available via apt, see `download-software.md`.

### `setup-bash.sh`

Installs the contents of `config-files/bashrc.sh` into `~/.bashrc`, replacing any previously installed block so the script is safe to re-run.

### `setup-starship.sh`

Installs nerd fonts (Hack, JetBrainsMono, FiraCode, Meslo, CascadiaCode), configures the default GNOME Terminal font to "Hack Nerd Font 12", and installs the [starship](https://starship.rs) prompt.

### `setup-git.sh`

Installs git if not already present, then configures git global defaults (user name, email, `init.defaultBranch`, `core.editor`, `pull.rebase`). Run interactively.

### `setup-npm.sh`

Installs NVM and the latest stable version of Node.js/npm via NVM.

### `setup-gaming.sh`

Configures gaming defaults, including the `ntsync` kernel module for improved Wine/Proton performance.

## `download-software.md`

Links to software not available via apt (Chrome, VS Code, Docker, Nvidia Docker, Gemini-CLI, Claude, Codex CLI, Slack). Displayed at the end of `init-system-setup.sh`.

## License

See `LICENSE` for details.
