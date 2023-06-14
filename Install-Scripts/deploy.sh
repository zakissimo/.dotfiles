#!/usr/bin/env bash

set -ex

echo "Define root password: "
passwd

command -v apt >/dev/null 2>&1 && apt update && apt upgrade && INSTALL="apt install -y --no-install-recommends"
command -v apk >/dev/null 2>&1 && apk update && apk upgrade && INSTALL="apk add -y"
command -v pacman >/dev/null 2>&1 && pacman update && pacman upgrade && INSTALL="pacman -S --noconfirm"

apps=(curl sudo)

function install {
    for app in $1; do
    which "$app" \
        || $2 "$app"
    done
}

install "${apps[@]}" "$INSTALL"

echo "Enter your username: "
read -r USER
useradd -m -G sudo -s /bin/bash "$USER"
su - "$USER"
echo "Define user password: "
passwd

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

install "${nixpkgs[@]}" "nix-env -iA"

sudo chsh -s "$(which zsh)" "$(whoami)"
