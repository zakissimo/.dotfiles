#!/bin/bash

pacman --noconfirm -S grub os-prober networkmanager iwd gnome-keyring polkit network-manager-applet
clear

options=(efi legacy)
select choice in "${options[@]}"; do
	case $choice in
	efi)
		pacman --noconfirm -S efibootmgr
		grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
		break
		;;
	legacy)
		lsblk
		echo "Indicate the boot disk (/dev/sdX): "
		read -r bootDisk
		grub-install "$bootDisk"
		break
		;;
	quit)
		echo "User exited without installing grub"
		exit 1
		;;
	*)
		echo "$REPLY is an invalid option"
		;;
	esac
done

sed -i 's/quiet/quiet pcie_aspm=force acpi_osi=/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/g' /etc/default/grub
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
sed -i "s/^#[multilib]$/[multilib]/" /etc/pacman.conf
sed -i "s/^#Include = /etc/pacman.d/mirrorlist$/Include = /etc/pacman.d/mirrorlist/" /etc/pacman.conf

mkinitcpio -P
grub-mkconfig -o /boot/grub/grub.cfg

# systemctl enable iwd.service
# systemctl enable systemd-resolved
systemctl enable NetworkManager.service

# cat <<EOF >/etc/iwd/main.conf
# [General]
# EnableNetworkConfiguration=true
# EOF
