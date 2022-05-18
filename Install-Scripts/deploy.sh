#!/usr/bin/env bash

if [ "$(id -u)" = 0 ]; then
	echo "Don't run this script as root!"
	exit 1
fi

sudo sed -i "s/^#Color$/Color/" /etc/pacman.conf
sudo sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
sudo sed -i "s/^#\[multilib\]$/\[multilib\]/" /etc/pacman.conf
sudo sed -i "s/^#Include = \/etc\/pacman\.d\/mirrorlist$/Include = \/etc\/pacman\.d\/mirrorlist\/" /etc/pacman.conf

sudo pacman -Fy
sudo pacman -Sy archlinux-keyring
sudo pacman -S - <pkglist.txt

pip install --upgrade pip
pip install pdftotext dbus-next psutil pywal wheel pynvim requests black autopep8 pylint pytest dbg debugpy ueberzug neovim-remote

git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
cd .. && rm -rf yay

yay -S --noconfirm picom-jonaburg-git megasync-bin nerd-fonts-cascadia-code ttf-impallari-lobster-font nerd-fonts-jetbrains-mono xkblayout-state stylua dracula-gtk-theme dracula-icons-git dracula-cursors-git notion-app-enhanced devour busted vim-vader-git ly lf atool i3lock-color nmap-netcat kvantum-qt5-git zeal timeshift timeshit-autosnap

sudo pacman -Sdd --asdeps libvterm

sudo npm install -g @fsouza/prettierd

mkdir -p "$HOME"/.local/bin

wal -i "$HOME"/.dotfiles/01kgv4.jpg

git clone https://github.com/betterlockscreen/betterlockscreen.git
cd betterlockscreen && sudo bash install.sh system latest true
cd .. && rm -rf betterlockscreen

betterlockscreen -u "$HOME"/.dotfiles/01kgv4.jpg --fx dimblur
betterlockscreen -l dimblur

sudo systemctl enable betterlockscreen@"$USER"
sudo systemctl enable ly.service

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
