#!/usr/bin/env bash

sudo sed -i "s/^#Color$/Color/" /etc/pacman.conf
sudo sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf

sudo pacman -Fy
sudo pacman -Sy archlinux-keyring
sudo pacman -S - <pkglist.txt

pip install --upgrade pip
pip install pdftotext dbus-next psutil pywal wheel pynvim requests black autopep8 pylint pytest dbg debugpy ueberzug neovim-remote

git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
cd .. && rm -rf yay

yay -S --noconfirm picom-jonaburg-git megasync-bin nerd-fonts-cascadia-code ttf-impallari-lobster-font nerd-fonts-jetbrains-mono xkblayout-state stylua dracula-gtk-theme dracula-icons-git dracula-cursors-git notion-app-enhanced devour busted vim-vader-git ly lf atool i3lock-color nmap-netcat kvantum-qt5-git zeal timeshift-bin timeshit-autosnap xkb-qwerty-fr

sudo pacman -Sdd --asdeps libvterm
