#!/usr/bin/env bash
# Configure git global defaults

if ! git config --global user.name >/dev/null; then
    read -p "Enter your full name: " REPLY
    git config --global user.name "$REPLY"
fi

if ! git config --global user.email >/dev/null; then
    read -p "Enter your email address: " REPLY
    git config --global user.email "$REPLY"
fi

if ! git config --global init.defaultBranch >/dev/null; then
    git config --global init.defaultBranch main
fi

if ! git config --global core.editor >/dev/null; then
    git config --global core.editor vim
fi

if ! git config --global pull.rebase >/dev/null; then
    git config --global pull.rebase true
fi
