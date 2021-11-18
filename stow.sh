#!/usr/bin/env bash

echo "#############"
echo "## Stowing ##"
echo "#############"
[ ! -d /home/zak/.config/qtile ] && sudo mkdir -p /home/zak/.config/qtile && touch /home/zak/.config/qtile/config.py
[ ! -d /home/zak/.config/qtile/scripts ] && sudo mkdir -p /home/zak/.config/qtile/scripts && touch /home/zak/.config/qtile/scripts/kekdate.sh && touch /home/zak/.config/qtile/scripts/kektime.sh && touch /home/zak/.config/qtile/scripts/autostart.sh && touch /home/zak/.config/qtile/scripts/kekvolume.sh && touch /home/zak/.config/qtile/scripts/Time4Salat.py
cd /home/zak/.dotfiles && stow -vSt /home/zak qtile || echo "Can't cd in dotfiles' folder! Failed stowing config.py!"
cd /home/zak/.dotfiles/desktop && stow -vSt /home/zak qtile || echo "Can't cd in dotfiles' folder! Failed stowing qtile scripts!"
