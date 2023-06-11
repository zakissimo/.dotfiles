#!/usr/bin/env bash

sudo apt update && sudo apt upgrade
sudo apt install curl -y
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -

apps=(
    exa
    fuse
    fzf
    git
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
        && sudo rm -rf /var/lib/apt/lists/*
done

sudo chsh -s "$(which zsh)" "$(whoami)"
