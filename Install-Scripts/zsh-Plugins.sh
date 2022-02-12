#!/usr/bin/env sh

mv "$HOME"/.oh-my-zsh "$HOME"/.config/oh-my-zsh

git clone https://github.com/agkozak/zsh-z "$HOME"/.config/oh-my-zsh/plugins/zsh-z
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME"/.config/oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME"/.config/oh-my-zsh/plugins/zsh-syntax-highlighting

rm "$HOME"/.zshrc.pre-oh-my-zsh
