#!/usr/bin/env bash

echo "#############"
echo "## Stowing ##"
echo "#############"
[ ! -d "$HOME"/.config/qtile ] && sudo mkdir -p "$HOME"/.config/qtile && sudo touch "$HOME"/.config/qtile/config.py && sudo touch "$HOME"/.config/qtile/autostart.sh
[ ! -d "$HOME"/.config/qtile/scripts ] && sudo mkdir -p "$HOME"/.config/qtile/scripts && sudo touch "$HOME"/.config/qtile/scripts/kekdate.sh && sudo touch "$HOME"/.config/qtile/scripts/kektime.sh && sudo touch "$HOME"/.config/qtile/scripts/autostart.sh && sudo touch "$HOME"/.config/qtile/scripts/kekvolume.sh && sudo touch "$HOME"/.config/qtile/scripts/Time4Salat.py

plateform=("laptop" "desktop")
select choice in "${plateform[@]}"; do
    case $choice in
        desktop)
            cd "$HOME"/.dotfiles && sudo stow -vSt "$HOME" qtile || echo "Can't cd in dotfiles' folder! Failed stowing config.py!"
            cd "$HOME"/.dotfiles/desktop && sudo stow -vSt "$HOME" qtile || echo "Can't cd in dotfiles' folder! Failed stowing qtile scripts!"
            ;;
        laptop)
            cd "$HOME"/.dotfiles && sudo stow -vSt "$HOME" qtile || echo "Can't cd in dotfiles' folder! Failed stowing config.py & autostart.sh!"
            cd "$HOME"/.dotfiles/laptop && sudo stow -vSt "$HOME" qtile || echo "Can't cd in dotfiles' folder! Failed stowing qtile scripts!"
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

