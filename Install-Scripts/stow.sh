#!/usr/bin/env bash

cloneAndStow() {

	files=$(find "$HOME"/.dotfiles/"$1" -type f)
	directories=$(find "$HOME"/.dotfiles/"$1" -type d)

	for path in $files; do
		real=$(echo "$path" | sed "s/.dotfiles\/$1\///g")
		[ -f "$real" ] && rm "$real"
	done
	for path in $directories; do
		real=$(echo "$path" | sed "s/.dotfiles\/$1\///g")
		[ ! -d "$real" ] && mkdir -vp "$real"
	done

	cd "$HOME"/.dotfiles && stow -vSt "$HOME" "$1" || echo "Failed stowing $1!"
}

apps=(qtile picom rofi kitty sxiv neovim zsh xinit profile starship wal-templates)

for app in "${apps[@]}"; do
	cloneAndStow "$app"
done

mkdir "$HOME"/.config/dunst
ln -s "$HOME"/.cache/wal/dunstrc "$HOME"/.config/dunst/dunstrc
# mkdir -vp "$HOME/.local/share/gxkb/"
# cp -r "$HOME/MEGA/Images/flags" "$HOME/.local/share/gxkb/"
