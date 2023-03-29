#!/usr/bin/env sh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mv "$HOME"/.oh-my-zsh "$HOME"/.config/oh-my-zsh

git clone https://github.com/agkozak/zsh-z "$HOME"/.config/oh-my-zsh/plugins/zsh-z
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME"/.config/oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME"/.config/oh-my-zsh/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME"/.config/oh-my-zsh/themes/powerlevel10k

rm "$HOME"/.zshrc.pre-oh-my-zsh
