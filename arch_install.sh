# == MY ARCH SETUP INSTALLER == #
#part1
printf '\033c'
echo "Welcome to Arch Linux Magic Script"
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
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
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
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
pacman --noconfirm -S grub efibootmgr os-prober networkmanager
# echo "Enter EFI partition: "
# read -r efipartition
# mkdir /boot/efi
# mount "$efipartition" /boot/efi
grub-install --force /dev/sda # --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S

systemctl enable NetworkManager.service
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "Enter Username: "
read -r username
useradd -m -G wheel -s /bin/zsh "$username"
passwd "$username"

echo "Pre-Installation Finish Reboot now"
echo "Pre-Installation Finish Reboot now"
echo "Pre-Installation Finish Reboot now"
echo "Pre-Installation Finish Reboot now"
echo "Pre-Installation Finish Reboot now"
echo "Pre-Installation Finish Reboot now"

exit
