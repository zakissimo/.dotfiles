#!/usr/bin/env bash

if [ "$(id -u)" = 0 ]; then
	echo "Don't run this script as root!"
	exit 1
fi

sudo pacman --needed --ask 4 -Sy - <pkglist.txt

git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
cd .. && sudo rm -rf yay

yay -S picom-jonaburg-git megasync-bin brave-bin nerd-fonts-cascadia-code ttf-impallari-lobster-font visual-studio-code-bin

sudo pip install pynvim requests black autopep8 pylint

sudo npm install neovim

mkdir -p "$HOME"/.local/bin
cp "$HOME"/.dotfiles/InstallationScripts/key "$HOME"/.local/bin/key

wal -i "$HOME"/.dotfiles/01kgv4.jpg

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mv "$HOME"/.oh-my-zsh "$HOME"/.config/oh-my-zsh

git clone https://github.com/agkozak/zsh-z "$HOME"/.config/oh-my-zsh/plugins/zsh-z
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME"/.config/oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME"/.config/oh-my-zsh/plugins/zsh-syntax-highlighting
