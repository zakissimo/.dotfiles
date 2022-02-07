#!/bin/bash

pacman --noconfirm -S grub os-prober networkmanager iwd

options=(efi legacy)
select choice in "${options[@]}"; do
	case $choice in
	efi)
		pacman --noconfirm -S efibootmgr
		grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
		;;
	legacy)
		lsblk
		echo "Indicate the boot disk (/dev/sdX): "
		read -r bootDisk
		grub-install "$bootDisk"
		;;
	exit)
		echo "User exited without installing grub"
		exit 0
		;;
	*)
		echo "$REPLY is an invalid option"
		;;
	esac
done

sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/g' /etc/default/grub
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable --now iwd.service
systemctl enable --now NetworkManager.service
