#!/usr/bin/env bash

LOCAL_STOW_DIR=".dotfiles/stow"
STOW_DIR="$HOME/$LOCAL_STOW_DIR"
STOW="$1"

cloneAndStow() {

    files=$(find "$STOW_DIR/$1" -type f)
    directories=$(find "$STOW_DIR/$1" -type d)

    for path in $files; do
        real="${path/\.dotfiles\/stow\/$1\//}"
        [ -f "$real" ] && rm "$real"
    done
    for path in $directories; do
        real="${path/\.dotfiles\/stow\/$1\//}"
        [ ! -d "$real" ] && mkdir -vp "$real"
    done

    cd "$HOME"/.dotfiles/stow && "$STOW" -vSt "$HOME" "$1" || echo "Failed stowing $1!"
}

apps=$(find "$STOW_DIR" -mindepth 1 -maxdepth 1 -type d)

for app in $apps; do
    cloneAndStow "${app##*/}"
done

for bin in "$HOME"/.dotfiles/bin/*; do
    [ ! -f "$HOME/.local/bin/${bin##*/}" ] && ln "$bin" "$HOME/.local/bin/${bin##*/}"
done
