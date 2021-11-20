#!/usr/bin/env bash

# == MY ARCH SETUP INSTALLER == #
#part1
printf '\033c'

read -rp "Do you want to automatically select the fastest mirrors? [y/n]" answer
if [[ $answer = y ]] ; then
    echo "Selecting the fastest mirrors"
    reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist --protocol https --download-timeout 5
fi

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
read -pr "Also create EFI partition ?" answer
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
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
timedatectl --no-ask-password set-timezone Europe/Paris
timedatectl --no-ask-password set-ntp 1
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/^#fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen
hwclock --systohc
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen
localectl --no-ask-password set-locale LANG="en_US.UTF-8" LC_TIME="fr_FR.UTF-8"
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
pacman --noconfirm -S grub efibootmgr os-prober networkmanager awk
# echo "Enter EFI partition: "
# read -r efipartition
# mkdir /boot/efi
# mount "$efipartition" /boot/efi
grub-install --force /dev/sda # --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

proc_type=$(lscpu | awk '/Vendor ID:/ {print $3}')
case "$proc_type" in
    GenuineIntel)
        print "Installing Intel microcode"
        pacman -S --noconfirm intel-ucode
        ;;
    AuthenticAMD)
        print "Installing AMD microcode"
        pacman -S --noconfirm amd-ucode
        ;;
esac

# Graphics Drivers find and install
read -pr "Is this a VM?" answer
if [[ $answer = y ]] ; then
    pacman -S xf86-video-vmware --noconfirm --needed
fi
if lspci | grep -E "NVIDIA|GeForce"; then
    pacman -S nvidia --noconfirm --needed
    nvidia-xconfig
elif lspci | grep -E "Radeon"; then
    pacman -S xf86-video-amdgpu --noconfirm --needed
elif lspci | grep -E "Integrated Graphics Controller"; then
    pacman -S libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils --needed --noconfirm
fi

systemctl enable NetworkManager.service
passwd
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "Enter Username: "
read -r username
useradd -m -G wheel -s /bin/zsh "$username"
passwd "$username"

exit
