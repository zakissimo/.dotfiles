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

apps=$(find "$HOME/.dotfiles/" -maxdepth 1 -type d | fzf -m)

for app in $apps; do
    cloneAndStow "${app##*/}"
done

[ ! -d "$HOME/.config/dunst" ] && mkdir -v "$HOME"/.config/dunst
[ ! -f "$HOME/.config/dunst/dunstrc" ] && ln -s "$HOME"/.cache/wal/dunstrc "$HOME"/.config/dunst/dunstrc

[ ! -d "$HOME/.local/bin" ] && mkdir -vp "$HOME/.local/bin"
for bin in "$HOME"/.dotfiles/bins/*; do
    [ ! -f "$HOME/.local/bin/${bin##*/}" ] && ln "$bin" "$HOME/.local/bin/${bin##*/}"
done
