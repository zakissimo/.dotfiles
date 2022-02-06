#!/usr/bin/env bash

cat <<"EOF"
      #############
      ## Stowing ##
      #############
EOF

cloneAndStow() {

	files=$(find "$HOME"/.dotfiles/"$1" -type f)
	directories=$(find "$HOME"/.dotfiles/"$1" -type d)

	for path in $files; do
		real=$(echo "$path" | sed "s/.dotfiles\/$1\///g")
		[ -f "$real" ] && rm "$real"
	done
	for path in $directories; do
		real=$(echo "$path" | sed "s/.dotfiles\/$1\///g")
		[ ! -d "$real" ] && mkdir -p "$real" && echo "Creating path: $real"
	done

	cd "$HOME"/.dotfiles && stow -vSt "$HOME" "$1" || echo "Failed stowing $1!"
}

apps=(qtile picom kitty sxiv neovim zsh xinit profile fontconfig starship)

for app in "${apps[@]}"; do
	cloneAndStow "$app"
done
