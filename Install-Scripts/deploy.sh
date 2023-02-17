#!/usr/bin/env sh

apt-get update && apt-get upgrade
apt-get install neovim git zsh ripgrep fzf lf stow python3 python3-pip delta

curl -sfLS https://install-node.vercel.app | bash -s --
chsh -s /bin/zsh

mkdir -p "$HOME"/.local/bin
