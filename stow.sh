#!/usr/bin/env bash

echo "#############"
echo "## Stowing ##"
echo "#############"
[ ! -d "$HOME"/.config/qtile/scripts ] && mkdir -p "$HOME"/.config/qtile/scripts
[ -f "$HOME"/.config/qtile/config.py ] && rm "$HOME"/.config/qtile/config.py

plateform=("laptop" "desktop" "quit")
select choice in "${plateform[@]}"; do
    case $choice in
        desktop)
            cd "$HOME"/.dotfiles && stow -vSt "$HOME" qtile || echo "Can't cd in dotfiles' folder! Failed stowing config.py!"
            cd "$HOME"/.dotfiles/desktop && stow -vSt "$HOME" qtile || echo "Can't cd in dotfiles' folder! Failed stowing qtile scripts!"
            break
            ;;
        laptop)
            cd "$HOME"/.dotfiles && stow -vSt "$HOME" qtile || echo "Can't cd in dotfiles' folder! Failed stowing config.py & autostart.sh!"
            cd "$HOME"/.dotfiles/laptop && stow -vSt "$HOME" qtile || echo "Can't cd in dotfiles' folder! Failed stowing qtile scripts!"
            break
            ;;
        quit)
            echo "Quitting before stowing ..."
            break
            ;;
        *)
            echo "Invalid option!"
            ;;
    esac
done

[ ! -d "$HOME"/.config/picom ] && mkdir -p "$HOME"/.config/picom
[ -f "$HOME"/.config/qtile/picom.conf ] && rm "$HOME"/.config/qtile/picom.conf
cd "$HOME"/.dotfiles && stow -vSt "$HOME" picom || echo "Can't cd in dotfiles' folder! Failed stowing!"

[ ! -d "$HOME"/.config/kitty ] && mkdir -p "$HOME"/.config/kitty
[ -f "$HOME"/.config/kitty/kitty.conf ] && rm "$HOME"/.config/kitty/kitty.conf
cd "$HOME"/.dotfiles && stow -vSt "$HOME" kitty || echo "Can't cd in dotfiles' folder! Failed stowing!"

[ ! -d "$HOME"/.config/sxiv/exec ] && mkdir -p "$HOME"/.config/sxiv/exec && touch
[ -f "$HOME"/.config/sxiv/exec/key-handler ] && rm "$HOME"/.config/sxiv/exec/key-handler
cd "$HOME"/.dotfiles && stow -vSt "$HOME" sxiv || echo "Can't cd in dotfiles' folder! Failed stowing!"

[ ! -d "$HOME"/.config/neovim ] && mkdir -p "$HOME"/.config/nvim
[ -f "$HOME"/.config/nvim/init.vim ] && rm "$HOME"/.config/nvim/init.vim
cd "$HOME"/.dotfiles && stow -vSt "$HOME" neovim || echo "Can't cd in dotfiles' folder! Failed stowing!"

cd "$HOME"/.dotfiles && stow -vSt "$HOME" starship || echo "Can't cd in dotfiles' folder! Failed stowing!"

rm "$HOME"/.zshrc
cd "$HOME"/.dotfiles && stow -vSt "$HOME" zsh || echo "Can't cd in dotfiles' folder! Failed stowing!"
