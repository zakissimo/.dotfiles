#!/usr/bin/env bash

echo "#############"
echo "## Stowing ##"
echo "#############"
[ ! -d "$HOME"/.config/qtile ] && sudo mkdir -p "$HOME"/.config/qtile && touch "$HOME"/.config/qtile/config.py && touch "$HOME"/.config/qtile/autostart.sh
[ ! -d "$HOME"/.config/qtile/scripts ] && sudo mkdir -p "$HOME"/.config/qtile/scripts && touch "$HOME"/.config/qtile/scripts/kekdate.sh && touch "$HOME"/.config/qtile/scripts/kektime.sh && touch "$HOME"/.config/qtile/scripts/autostart.sh && touch "$HOME"/.config/qtile/scripts/kekvolume.sh && touch "$HOME"/.config/qtile/scripts/Time4Salat.py

plateform=("laptop" "desktop")
select choice in "${plateform[@]}"; do
    case $choice in
        desktop)
            cd "$HOME"/.dotfiles && stow -vSt "$HOME" qtile || echo "Can't cd in dotfiles' folder! Failed stowing config.py!"
            cd "$HOME"/.dotfiles/desktop && stow -vSt "$HOME" qtile || echo "Can't cd in dotfiles' folder! Failed stowing qtile scripts!"
            ;;
        laptop)
            cd "$HOME"/.dotfiles && stow -vSt "$HOME" qtile || echo "Can't cd in dotfiles' folder! Failed stowing config.py & autostart.sh!"
            cd "$HOME"/.dotfiles/laptop && stow -vSt "$HOME" qtile || echo "Can't cd in dotfiles' folder! Failed stowing qtile scripts!"
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

