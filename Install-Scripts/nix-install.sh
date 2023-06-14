#!/usr/bin/env bash


function install {
    for app in "$@"; do
    which "$app" \
        || $INSTALL "$app"
    done
}
sh <(curl -L https://nixos.org/nix/install) --no-daemon

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
    nixpkgs.npm
    nixpkgs.nvim
    nixpkgs.ripgrep
    nixpkgs.ssh
    nixpkgs.stow
    nixpkgs.tmux
    nixpkgs.zsh
)

INSTALL="nix-env -iA"

install "${nixpkgs[@]}"

sudo chsh -s "$(which zsh)" "$USER"
