#!/usr/bin/env bash

sudo pacman --needed --ask 4 -Sy - < pkglist.txt

echo "#########################################################"
echo "## ............... Installing yay .................... ##"
echo "#########################################################"
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
cd .. && sudo rm -rf yay

yay -S picom-jonaburg-git megasync-bin brave-bin nerd-fonts-cascadia-code ttf-impallari-lobster-font visual-studio-code-bin

sudo pip install pynvim requests black autopep8 pylint

sudo npm install neovim

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
