#!/usr/bin/env bash

cd "$HOME" || echo "Can't cd home!"

git clone https://github.com/bakkeby/dmenu-flexipatch

cp "$HOME"/.dotfiles/suckless/dmenu/patches.h "$HOME"/dmenu-flexipatch/patches.h

cd "$HOME"/dmenu-flexipatch || echo "Can't cd in dmenu folder!"

sudo make clean install

rm -rf "$HOME"/dmenu-flexipatch
