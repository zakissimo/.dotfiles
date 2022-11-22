#!/usr/bin/env bash

if [ "$(id -u)" = 0 ]; then
	echo "Don't run this script as root!"
	exit 1
fi

sudo sed -i "s/^#Color$/Color/" /etc/pacman.conf
sudo sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
echo "[multilib]" | sudo tee -a /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf

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

mkdir -p "$HOME"/.local/bin

wal -i "$HOME"/.dotfiles/01kgv4.jpg

git clone https://github.com/betterlockscreen/betterlockscreen.git
cd betterlockscreen && bash install.sh user latest true
cd .. && rm -rf betterlockscreen

betterlockscreen -u "$HOME"/.dotfiles/01kgv4.jpg --fx dimblur
betterlockscreen -l dimblur

sudo systemctl enable betterlockscreen@"$USER"
sudo systemctl enable ly.service
