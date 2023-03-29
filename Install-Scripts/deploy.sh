#!/usr/bin/env bash

if [ "$(id -u)" = 0 ]; then
	echo "Don't run this script as root!"
	exit 1
fi

sudo sed -i "s/^#Color$/Color/" /etc/pacman.conf
sudo sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
echo "[multilib]" | sudo tee -a /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf

git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
cd .. && rm -rf yay

yay -S nerd-fonts-cascadia-code ttf-impallari-lobster-font nerd-fonts-jetbrains-mono xkblayout-state dracula-gtk-theme dracula-cursors-git dracula-icons-git dracula-cursors-git devour kvantum-qt5-git zeal xkb-qwerty-fr hyprland-bin megasync-bin foot waybar-hyprland swaybg swaylock-effects wofi wlogout pcmanfm ttf-jetbrains-mono-nerd ttf-joypixels polkit-gnome python-requests swappy grim slurp pamixer brightnessctl gvfs bluez bluez-utils lxappearance xfce4-settings xdg-desktop-portal-hyprland-git chafa bat ripgrep moar man-db unzip

pip install --upgrade pip
pip install dbus-next psutil pywal wheel pynvim requests neovim-remote

sudo pacman -Sdd --asdeps libvterm

mkdir -p "$HOME"/.local/bin
