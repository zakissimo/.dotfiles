#!/usr/bin/env bash

#The goal for now is to create a dependency list
#When I learn more about bash to make a deployment script

#Create Override file

#Check for yay install if not present

yay -S picom-jonaburg-git ttf-cascadia-code ttf-sil-kawkab-mono &

#git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
#~/.emacs.d/bin/doom install

sudo pacman -S exa xclip xcope sxiv megasync nvim emacs starship fzf curl &

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

sudo pacman -Syu 
