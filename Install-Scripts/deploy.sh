#!/usr/bin/env bash

sudo apt update && sudo apt upgrade

apps=(
    curl
    delta
    exa
    fuse
    fzf
    git
    lua
    nodejs
    npm
    ripgrep
    ssh
    stow
    tmux
    zsh
)

for app in "${apps[@]}"; do
    which "$app" \
        || DEBIAN_FRONTEND=noninteractive \
        sudo apt install -y \
        --no-install-recommends \
        "$app" \
        && rm -rf /var/lib/apt/lists/*
done

sudo chsh -s "$(which zsh)" "$(whoami)"
