#!/usr/bin/env bash

sudo cp "$HOME/.dotfiles/keyboard/arabic.el" "/usr/share/emacs/27.2/lisp/leim/quail/"
sudo cp "$HOME/.dotfiles/keyboard/fr" "/usr/share/X11/xkb/symbols/"
sudo cp "$HOME/.dotfiles/keyboard/ara" "/usr/share/X11/xkb/symbols/"
sudo rm "/usr/share/emacs/27.2/lisp/leim/quail/arabic.elc"

ln "$HOME"/.dotfiles/keyboard/key "$HOME"/.local/bin/key

options=(yes no)
select choice in "${options[@]}"; do
	case $choice in
	yes)
		sudo pacman -S emacs

		echo "#########################################################"
		echo "## Installing Doom Emacs. This may take a few minutes. ##"
		echo "#########################################################"
		[ -d ~/.emacs.d ] && rm -rf ~/.emacs.d
		[ -f ~/.emacs ] && rm ~/.emacs
		git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
		~/.emacs.d/bin/doom install
		;;
	no)
		exit 0
		;;
	*)
		echo "$REPLY is an invalid option"
		;;
	esac
done
