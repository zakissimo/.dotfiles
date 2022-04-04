#!/usr/bin/env bash

if [ "$(id -u)" = 0 ]; then
	echo "Don't run this script as root!"
	exit 1
fi

sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
sed -i "s/^#\[multilib\]$/\[multilib\]/" /etc/pacman.conf
sed -i "s/^#Include = \/etc\/pacman\.d\/mirrorlist$/Include = \/etc\/pacman\.d\/mirrorlist\/" /etc/pacman.conf

sudo pacman -Fy
sudo pacman --needed --ask 4 -Sy - <pkglist.txt

git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
cd .. && rm -rf yay

curl -fsSL https://rpm.nodesource.com/setup_17.x | sudo bash -

yay -S --noconfirm picom-jonaburg-git megasync-bin brave-git nerd-fonts-cascadia-code ttf-impallari-lobster-font nerd-fonts-jetbrains-mono xkblayout-state stylua dracula-gtk-theme dracula-icons-git dracula-cursors-git notion-app-enhanced devour busted vim-vader-git ly lf atool vimv-git i3lock-color dasht neovim-git

sudo pacman -Sdd --asdeps libvterm

dasht-docsets-install bash python javascript lua

sudo pip install wheel pynvim requests black autopep8 pylint pytest dbg debugpy
sudo npm install -g @fsouza/prettierd

mkdir -p "$HOME"/.local/bin

wal -i "$HOME"/.dotfiles/01kgv4.jpg

git clone https://github.com/betterlockscreen/betterlockscreen.git
cd betterlockscreen && sudo bash install.sh system latest true
cd .. && rm -rf betterlockscreen

betterlockscreen -u "$HOME"/.dotfiles/01kgv4.jpg --fx dimblur
betterlockscreen -l dimblur

sudo systemctl enable ly.service

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
