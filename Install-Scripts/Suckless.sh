#!/usr/bin/env bash

cd "$HOME" || echo "Can't cd home!"

git clone https://github.com/bakkeby/dmenu-flexipatch

rm "$HOME"/dmenu-flexipatch/config.def.h
cp "$HOME"/.dotfiles/suckless/dmenu/config.h "$HOME"/dmenu-flexipatch/config.h

cd "$HOME"/dmenu-flexipatch || echo "Can't cd in dmenu folder!"

sudo make clean install
