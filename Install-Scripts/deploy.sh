#!/usr/bin/env bash

set -ex

echo "Define root password: "
passwd

command -v apt >/dev/null 2>&1 && apt update -y && INSTALL="apt install -y"
command -v apk >/dev/null 2>&1 && apk update && INSTALL="apk add"
command -v pacman >/dev/null 2>&1 && pacman -Syyu --noconfirm && INSTALL="pacman -S --noconfirm"

apps=(curl sudo)

function install {
    for app in "$@"; do
    which "$app" \
        || $INSTALL "$app"
    done
}

install "${apps[@]}"

echo "Enter your username: "
read -r NEW_USER
useradd -m -G sudo -s /bin/bash "$NEW_USER"

cp /.dotfiles/Install-Scripts/nix-install.sh /home/"$NEW_USER"
chown "$NEW_USER":"$NEW_USER" /home/"$NEW_USER"/nix-install.sh
chmod +x /home/"$NEW_USER"/nix-install.sh

mkdir -p /nix
chown -R "$NEW_USER":"$NEW_USER" /nix

su "$NEW_USER" -c "$(/home/"$NEW_USER"/nix-install.sh)"
