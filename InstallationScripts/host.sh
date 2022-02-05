#!/usr/bin/sh

echo "How shall we call this machine? "
read -r hostname
echo "$hostname" > /etc/hostname

cat << EOF >> /etc/hosts
127.0.0.1       localhost
::1             localhost
127.0.1.1       $hostname.localdomain $hostname
EOF
