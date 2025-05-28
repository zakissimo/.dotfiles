#!/usr/bin/env bash

STOW="$(which stow)"
STOW_DIR="$HOME/.dotfiles/stow"
CONFIG_DIR="$HOME/.config"

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

cloneAndAdopt() {
    files=$(find "$CONFIG_DIR/$1" -type f)
    directories=$(find "$CONFIG_DIR/$1" -type d)

    for path in $directories; do
        real="${path/\.config/\.dotfiles\/stow\/$1\/.config/}"
        [ ! -d "$real" ] && mkdir -vp "$real"
    done
    for path in $files; do
        real="${path/\.config/\.dotfiles\/stow\/$1\/.config/}"
        [ ! -f "$real" ] && touch "$real"
    done

    cd "$HOME"/.dotfiles/stow && "$STOW" -vSt "$HOME" --adopt "$1" || echo "Failed stowing $1!"
}

command="$1"
package="$2"

case "$command" in
stow)
    if [ -n "$package" ]; then
        cloneAndStow "$package"
    else
        apps=$(find "$STOW_DIR" -mindepth 1 -maxdepth 1 -type d)
        for app in $apps; do
            cloneAndStow "${app##*/}"
        done
    fi
    ;;
adopt)
    if [ -n "$package" ]; then
        cloneAndAdopt "$package"
    else
        echo "Please specify a package to adopt."
        exit 1
    fi
    ;;
*)
    echo "Usage:"
    echo "  $0 stow [package]   # Stow all or specific package"
    echo "  $0 adopt <package>  # Adopt a package from ~/.config"
    exit 1
    ;;
esac
