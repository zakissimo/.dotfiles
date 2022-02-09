#!/usr/bin/env sh

sudo pacman -S emacs

echo "#########################################################"
echo "## Installing Doom Emacs. This may take a few minutes. ##"
echo "#########################################################"
[ -d ~/.emacs.d ] && rm -rf ~/.emacs.d
[ -f ~/.emacs ] && rm ~/.emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

sudo cp "$HOME/.dotfiles/keyboard/arabic.el" "/usr/share/emacs/27.2/lisp/leim/quail/"
sudo cp "$HOME/.dotfiles/keyboard/fr" "/usr/share/X11/xkb/symbols/"
sudo cp "$HOME/.dotfiles/keyboard/ara" "/usr/share/X11/xkb/symbols/"
