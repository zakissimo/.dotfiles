#!/usr/bin/env bash

set -xe

function install {
    for app in "$@"; do
    command -v "$app" >/dev/null 2>&1 \
        || $INSTALL "$app"
    done
}

sh <(curl -L https://nixos.org/nix/install) --no-daemon

. "$HOME"/.nix-profile/etc/profile.d/nix.sh

nixpkgs=(
    nixpkgs.curl
    nixpkgs.delta
    nixpkgs.exa
    nixpkgs.fuse
    nixpkgs.fzf
    nixpkgs.git
    nixpkgs.lazygit
    nixpkgs.lua
    nixpkgs.nodejs
    nixpkgs.neovim
    nixpkgs.ripgrep
    nixpkgs.openssh
    nixpkgs.stow
    nixpkgs.tmux
    nixpkgs.zsh
)

INSTALL="nix-env -iA"

install "${nixpkgs[@]}"

cd && git clone https://github.com/zakissimo/.dotfiles \
    && cd .dotfiles \
    && git remote set-url origin git@github:zakissimo/.dotfiles

ZSH_PATH=$(whereis zsh | cut -d' ' -f2)

sudo sh -c "echo $ZSH_PATH >> /etc/shells"
chsh -s "$ZSH_PATH" "$USER"
