#!/usr/bin/env bash

if [ "$(id -u)" = 0 ]; then
	echo "Don't run this script as root!"
	exit 1
fi

sudo pacman --needed --ask 4 -Sy - <pkglist.txt

git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
cd .. && sudo rm -rf yay

yay -S --noconfirm picom-jonaburg-git megasync-bin brave-bin nerd-fonts-cascadia-code ttf-impallari-lobster-font visual-studio-code-bin xkblayout-state pa-applet-git stylua dracula-gtk-theme dracula-icons-git dracula-cursors-git notion-app-enhanced devour busted

sudo pip install pynvim requests black autopep8 pylint

sudo npm install -g neovim prettier

mkdir -p "$HOME"/.local/bin

wal -i "$HOME"/.dotfiles/01kgv4.jpg

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
