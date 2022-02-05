#!/usr/bin/env bash

sudo pacman -S --noconfirm --needed sed
sudo sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf

sudo pacman -S --noconfirm --needed mesa xorg-server xorg-xinit xorg-xkill xorg-xsetroot xorg-xbacklight xorg-xprop qtile zsh stow \
    noto-fonts noto-fonts-cjk ttf-jetbrains-mono ttf-joypixels ttf-font-awesome \
    sxiv mpv zathura zathura-pdf-mupdf ffmpeg imagemagick  \
    fzf xwallpaper kitty xterm exa btop xclip xcape stow neovim \
    starship curl light pcmanfm python python-pip python-pywal youtube-dl \
    zip unzip unrar p7zip xdotool papirus-icon-theme brightnessctl  \
    git sxhkd zsh emacs dash libnotify dunst dhcpcd onlyoffice-bin visual-studio-code-bin \
    gimp gcc shellcheck

sudo pip install pynvim
sudo pip install autopep8

wal -i "$HOME"/.dotfiles/01kgv4.jpg

echo "#########################################################"
echo "## ............... Installing yay .................... ##"
echo "#########################################################"
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
cd .. && sudo rm -rf yay

yay -S picom-jonaburg-git megasync-bin brave-bin nerd-fonts-cascadia-code ttf-impallari-lobster-font lxappearance xflux notion-app-enhanced

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sh -c "$(curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)"

git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
git clone https://github.com/agkozak/zsh-z "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-z

# echo "#########################################################"
# echo "## Installing Doom Emacs. This may take a few minutes. ##"
# echo "#########################################################"
# [ -d ~/.emacs.d ] && mv ~/.emacs.d ~/.emacs.d.bak
# [ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.bak
# git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
# ~/.emacs.d/bin/doom install

#echo '[[ $(fgconsole 2>/dev/null) == 1) ]] && exec startx -- vt1' >> /home/zak/.bash_profile

#sudo cp "./keyboard/arabic.el" "/usr/share/emacs/27.2/lisp/leim/quail/"
#sudo cp "./keyboard/fr" "/usr/share/X11/xkb/symbols/"
#sudo cp "./keyboard/ara" "/usr/share/X11/xkb/symbols/"

#touch blacklist.conf
#echo 'blacklist dw_dmac\nblacklist dw_dmac_core' > blacklist.conf
#sudo mv blacklist.conf /etc/modprobe.d/blacklist.conf
