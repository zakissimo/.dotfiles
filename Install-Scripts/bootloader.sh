#!/bin/bash

pacman --noconfirm -S grub os-prober networkmanager iwd gnome-keyring polkit network-manager-applet amd-ucode

mkinitcpio -P
clear

options=(efi legacy quit)
select choice in "${options[@]}"; do
	case $choice in
	efi)
		bootctl --path=/boot install
		cat <<-EOF >/boot/loader/loader.conf
			default arch.conf
			timeout 3
			editor 0
		EOF
		cat <<-EOF >/boot/loader/entries/arch.conf
			title  Arch Linux
			linux  /vmlinuz-linux
			initrd /amd-ucode.img
			initrd /initramfs-linux.img
		EOF
		break
		;;
	legacy)
		lsblk
		echo "Indicate the boot disk (/dev/sdX): "
		read -r bootDisk
		grub-install "$bootDisk"
		sed -i 's/quiet/quiet pcie_aspm=force acpi_osi=/g' /etc/default/grub
		sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
		sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/g' /etc/default/grub
		grub-mkconfig -o /boot/grub/grub.cfg
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

# systemctl enable iwd.service
# systemctl enable systemd-resolved
systemctl enable NetworkManager.service

# cat <<EOF >/etc/iwd/main.conf
# [General]
# EnableNetworkConfiguration=true
# EOF