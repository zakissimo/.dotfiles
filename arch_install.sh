# == MY ARCH SETUP INSTALLER == #
#part1
printf '\033c'
echo "Welcome to Arch Linux Magic Script"
read -rp "Do you want to automatically select the fastest mirrors? [y/n]" answer
if [[ $answer = y ]] ; then
  echo "Selecting the fastest mirrors"
  reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist --protocol https --download-timeout 5
fi
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
pacman --noconfirm -Sy archlinux-keyring
loadkeys fr
timedatectl set-ntp true
lsblk
echo "Enter the drive: "
read -r drive
cfdisk "$drive"
echo "Enter the linux partition: "
read -r partition
mkfs.ext4 "$partition"
read -pr "Did you also create efi partition? [y/n]" answer
if [[ $answer = y ]] ; then
  echo "Enter EFI partition: "
  read -r efipartition
  mkfs.vfat -F 32 "$efipartition"
fi
mount "$partition" /mnt
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
sed '1,/^#part2$/d' arch_install.sh > /mnt/arch_install2.sh
chmod +x /mnt/arch_install2.sh
arch-chroot /mnt ./arch_install2.sh
exit

#part2
printf '\033c'
pacman -S --noconfirm sed
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc
echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=fr" > /etc/vconsole.conf
echo "Hostname: "
read -r hostname
echo "$hostname" > /etc/hostname
{
    echo "127.0.0.1       localhost"
    "::1             localhost"
    "127.0.1.1       $hostname.localdomain $hostname"
} >> /etc/hosts
mkinitcpio -P
passwd
pacman --noconfirm -S grub efibootmgr os-prober
# echo "Enter EFI partition: "
# read -r efipartition
# mkdir /boot/efi
# mount "$efipartition" /boot/efi
grub-install /dev/sda # --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S --noconfirm xorg-server xorg-xinit xorg-xkill xorg-xsetroot xorg-xbacklight xorg-xprop \
     noto-fonts noto-fonts-cjk ttf-jetbrains-mono ttf-joypixels ttf-font-awesome \
     sxiv mpv zathura zathura-pdf-mupdf ffmpeg imagemagick  \
     fzf man-db xwallpaper kitty xterm exa xclip xcape stow neovim starship fzf curl light pcmanfm python-pip python-pywal youtube-dl unclutter xclip maim \
     zip unzip unrar p7zip xdotool papirus-icon-theme brightnessctl  \
     dosfstools ntfs-3g git sxhkd zsh emacs dash \
     xcompmgr libnotify dunst slock jq \
     dhcpcd networkmanager rsync pamixer

systemctl enable NetworkManager.service
rm /bin/sh
ln -s dash /bin/sh
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "Enter Username: "
read -r username
useradd -m -G wheel -s /bin/zsh "$username"
passwd "$username"
echo "Pre-Installation Finish Reboot now"
ai3_path=/home/$username/arch_install3.sh
sed '1,/^#part3$/d' arch_install2.sh > "$ai3_path"
chown "$username":"$username" "$ai3_path"
chmod +x "$ai3_path"
su -c "$ai3_path" -s /bin/sh "$username"
exit

#part3
printf '\033c'

echo "#########################################################"
echo "## ............... Installing yay .................... ##"
echo "#########################################################"
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
cd .. && sudo rm -rf yay

yay -S picom-jonaburg-git brave-bin ttf-cascadia-code ttf-impallari-lobster-font lxappearance xflux

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sh -c "$(curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)"

git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
git clone https://github.com/agkozak/zsh-z "$ZSH_CUSTOM"/plugins/zsh-z

exit
