#!/usr/bin/env bash

#The goal for now is to create a dependency list
#When I learn more about bash to make a deployment script

#touch override
#echo 'zak ALL=(ALL) NOPASSWD: ALL' > override

sudo pacman -S xorg xorg-xinit noto-fonts noto-fonts-cjk imagemagick git mypaint qtile python-pip kitty exa xclip xcape stow sxiv neovim emacs starship fzf curl light pcmanfm xterm
sudo pip install pywal

echo "#########################################################"
echo "## ............... Installing yay .................... ##"
echo "#########################################################"
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
cd .. && sudo rm -rf yay

yay -S picom-jonaburg-git brave-bin ttf-font-awesome ttf-cascadia-code ttf-impallari-lobster-font ttf-joypixels lxappearance xflux zsh

sudo chsh "$USER" -s "/bin/zsh" && echo -e "zsh has been set as your default USER shell. Logging out is required for this take effect."

# echo "#########################################################"
# echo "## Installing Doom Emacs. This may take a few minutes. ##"
# echo "#########################################################"
# [ -d ~/.emacs.d ] && mv ~/.emacs.d ~/.emacs.d.bak
# [ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.bak
# git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
# ~/.emacs.d/bin/doom install

#echo '[[ $(fgconsole 2>/dev/null) == 1) ]] && exec startx -- vt1' >> /home/zak/.bash_profile

#sudo cp "./keyboard/arabic.el" "/usr/share/emacs/27.2/lisp/leim/quail/"
#sudo cp "./keyboard/fr" "/usr/share/X11/xkb/symbols/"
#sudo cp "./keyboard/ara" "/usr/share/X11/xkb/symbols/"

#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z

#touch blacklist.conf
#echo 'blacklist dw_dmac\nblacklist dw_dmac_core' > blacklist.conf
#sudo mv blacklist.conf /etc/modprobe.d/blacklist.conf
