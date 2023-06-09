#!/usr/bin/env bash

sudo apt update && sudo apt upgrade -y

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
    which "$app" || sudo apt install "$app" -y
done

sudo chsh -s "$(which zsh)" "$(whoami)"
