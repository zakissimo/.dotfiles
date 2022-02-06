#!/bin/sh

pacman --noconfirm -S grub efibootmgr os-prober networkmanager sed

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager.service
