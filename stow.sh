#!/usr/bin/env bash

echo "#############"
echo "## Stowing ##"
echo "#############"

clone_file_sys () {
	paths=$(find "$HOME"/.dotfiles/"$1")
	for path in $paths
	do 
		real=$(echo "$path" | sed "s/.dotfiles\/$1\///g")
		[ -f "$real" ] && rm "$real"
		[ ! -d "$real" ] && mkdir -p "$real" && echo "Creating path: $real"
		cd "$HOME"/.dotfiles && stow -vSt "$HOME" "$1" || echo "Failed stowing $1!"
	done
}

clone_file_sys qtile
clone_file_sys picom
clone_file_sys kitty
clone_file_sys sxiv
clone_file_sys neovim
clone_file_sys zsh
clone_file_sys xinit
clone_file_sys fontconfig
