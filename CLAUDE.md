# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This repository contains shell scripts and configuration files for setting up a new Linux (Ubuntu/Debian) system consistently. It is not a software project with a build system or tests — changes are validated by running scripts manually.

## Key Scripts

- **`init-system-setup.sh`** — Run once on a fresh system. Installs apt packages, Rust, uv, and mdcat. Targets Ubuntu/Debian only.
- **`setup-starship.sh`** — Run after `init-system-setup.sh`. Installs nerd fonts, configures the default GNOME Terminal font, and installs the starship prompt.
- **`setup-git.sh`** — Run interactively after `init-system-setup.sh`. Configures git globals: `user.name`, `user.email`, `init.defaultBranch`, `core.editor`, `pull.rebase`.
- **`setup-npm.sh`** — Installs NVM and the latest stable Node.js/npm via NVM.
- **`install-shell-config.sh`** — Copies `shell-config/` files to `~/.config/shell/`, symlinks `~/.bashrc` to `~/.config/shell/bashrc`, and initializes `~/.config/shell` as a local git repo for tracking personal shell changes.

## Architecture

Scripts are run in order after a fresh install:

1. `init-system-setup.sh` — system-level packages and tools (requires sudo)
2. `setup-starship.sh` — nerd fonts and starship prompt
3. `setup-git.sh` — git globals (interactive)
4. `setup-npm.sh` — NVM and Node.js (optional)
5. `install-shell-config.sh` — user-level shell config (no sudo needed)

### `shell-config/` directory

These files get deployed to `~/.config/shell/` by `install-shell-config.sh`:

- **`shell-config.sh`** — Sourced by `~/.bashrc`. Sets `LESS` flags, defines `ll` alias and `edit()` function (opens gedit in background), enables starship prompt, adds `~/.local/bin` to PATH, and binds Up/Down arrows to history search.
- **`starship.toml`** — Starship prompt config. Deployed to `~/.config/shell/starship.toml` — note: starship reads from `~/.config/starship.toml` by default, so a symlink or `STARSHIP_CONFIG` env var may be needed if this isn't handled elsewhere.
- **`gitignore`** — Deployed as `~/.config/shell/.gitignore`. Excludes `api-keys.sh` from the personal shell config git repo.

### API keys

`~/.config/shell/api-keys.sh` is created empty with `chmod 600` and is sourced by `shell-config.sh`. It is excluded from git via `gitignore`. A symlink at `~/.api-keys.sh` points to it.

## Deployment

To apply changes made in this repo to the local system, re-run the relevant script:

```bash
./install-shell-config.sh   # re-deploy shell config files
```

For system-level changes (new packages, font updates), re-run `init-system-setup.sh` — it is idempotent for most steps (checks before installing).
