#!/usr/bin/env bash

echo "#########################################################"
echo "## ............... Installing yay .................... ##"
echo "#########################################################"
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
cd .. && sudo rm -rf yay

yay -S picom-jonaburg-git nvim-packer-git megasync-bin brave-bin nerd-fonts-cascadia-code ttf-impallari-lobster-font

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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

#sudo cp "./keyboard/arabic.el" "/usr/share/emacs/27.2/lisp/leim/quail/"
#sudo cp "./keyboard/fr" "/usr/share/X11/xkb/symbols/"
#sudo cp "./keyboard/ara" "/usr/share/X11/xkb/symbols/"
