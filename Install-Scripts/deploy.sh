#!/usr/bin/env bash

set -xe

read -pr "Define root password? [Y/n]" ROOT_PASSWD
case "$ROOT_PASSWD" in
    [nN])
        echo "Skipping root password"
        ;;
    *)
        echo "Define root password:"
        passwd
        ;;
esac

command -v apt >/dev/null 2>&1 && apt update -y && INSTALL="apt install -y" && SUDO_GRP="sudo"
command -v pacman >/dev/null 2>&1 && pacman -Syyu --noconfirm && INSTALL="pacman -S --noconfirm" && SUDO_GRP="wheel"

apps=(curl sudo)

function install {
    for app in "$@"; do
    command -v "$app" >/dev/null 2>&1 \
        || $INSTALL "$app"
    done
}

install "${apps[@]}"

read -pr "Use existing user? [Y/n]" EXISTING_USER
case "$EXISTING_USER" in
    [nN])
        read -pr "Enter new username:" NEW_USER
        useradd -m -G "$SUDO_GRP" -s /bin/bash "$NEW_USER"
        read -pr "Define user password? [Y/n]" USER_PASSWD
        case "$USER_PASSWD" in
            [nN])
                echo "Skipping root password"
                ;;
            *)
                echo "Define root password:"
                passwd "$NEW_USER"
        ;;
        esac
        ;;
    *)
        while true; do
        read -pr "Enter existing username:" NEW_USER
        if id "$NEW_USER" &>/dev/null; then
            echo "User $NEW_USER exists."
            break
        else
            echo "User $NEW_USER does not exist. Please try again."
        fi
        done
esac

cp /.dotfiles/Install-Scripts/nix-install.sh /home/"$NEW_USER"
chown "$NEW_USER":"$NEW_USER" /home/"$NEW_USER"/nix-install.sh
chmod +x /home/"$NEW_USER"/nix-install.sh

mkdir -p /nix
chown -R "$NEW_USER":"$NEW_USER" /nix

su "$NEW_USER" -c /home/"$NEW_USER"/nix-install.sh

rm -rf /home/"$NEW_USER"/nix-install.sh

rm -rf /.dotfiles
