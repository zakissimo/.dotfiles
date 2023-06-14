#!/usr/bin/env bash

set -ex

echo "Define root password: "
passwd

command -v apt >/dev/null 2>&1 && apt update -y && INSTALL="apt install -y --no-install-recommends"
command -v apk >/dev/null 2>&1 && apk update -y && INSTALL="apk add -y"
command -v pacman >/dev/null 2>&1 && pacman update && pacman upgrade && INSTALL="pacman -S --noconfirm"

apps=(curl sudo)

function install {
    for app in "$@"; do
    which "$app" \
        || $INSTALL "$app"
    done
}

install "${apps[@]}"

echo "Enter your username: "
read -r USER
useradd -m -G sudo -s /bin/bash "$USER"

mv /.dotfiles/Install-Scripts/nix-install.sh /home/"$USER"
chown "$USER":"$USER" /home/"$USER"/nix-install.sh
chmod +x /home/"$USER"/nix-install.sh

su - "$USER" -c "$(/home/"$USER"/nix-install.sh)"
