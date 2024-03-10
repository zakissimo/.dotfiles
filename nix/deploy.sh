#!/usr/bin/env bash

set -xe

[ -f /etc/nixos/configuration.nix ] && sudo rm /etc/nixos/configuration.nix

sudo ln "$HOME"/.dotfiles/nix/configuration.nix /etc/nixos/configuration.nix

[ ! -f "$HOME"/.config/home-manager/home.nix ] && home-manager init

[ -f "$HOME"/.config/home-manager/home.nix ] && rm "$HOME"/.config/home-manager/home.nix

ln "$HOME"/.dotfiles/nix/home.nix "$HOME"/.config/home-manager/home.nix
