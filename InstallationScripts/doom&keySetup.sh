#!/usr/bin/env sh

echo "#########################################################"
echo "## Installing Doom Emacs. This may take a few minutes. ##"
echo "#########################################################"
[ -d ~/.emacs.d ] && mv ~/.emacs.d ~/.emacs.d.bak
[ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.bak
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

sudo cp "./keyboard/arabic.el" "/usr/share/emacs/27.2/lisp/leim/quail/"
sudo cp "./keyboard/fr" "/usr/share/X11/xkb/symbols/"
sudo cp "./keyboard/ara" "/usr/share/X11/xkb/symbols/"
