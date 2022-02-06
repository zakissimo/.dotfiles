#!/bin/sh

echo "KEYMAP=fr" >/etc/vconsole.conf

ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc

cat <<EOF >/etc/locale.gen
en_US.UTF-8 UTF-8
fr_FR.UTF-8 UTF-8
EOF

locale-gen

cat <<EOF >/etc/locale.conf
LANG=en_US.UTF-8
LC_ADDRESS=fr_FR.UTF-8
LC_IDENTIFICATION=fr_FR.UTF-8
LC_MEASUREMENT=fr_FR.UTF-8
LC_MONETARY=fr_FR.UTF-8
LC_NAME=fr_FR.UTF-8
LC_NUMERIC=fr_FR.UTF-8
LC_PAPER=fr_FR.UTF-8
LC_TELEPHONE=fr_FR.UTF-8
LC_TIME=fr_FR.UTF-8
EOF
