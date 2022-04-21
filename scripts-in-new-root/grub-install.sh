#!/bin/bash

if [[ $1 == "" ]]; then
	echo "You have to specify a hostname for your machine!"
	exit 0
fi

if [[ $2 == "" ]]; then
	echo "You have to enter a username!"
	exit 0
fi


ln -s /usr/share/zoneinfo/Europa/Vienna /etc/localtime
vim /etc/locale.gen
locale-gen
echo "LANG=de_DE.UTF-8" > /etc/locale.conf
echo "KEYMAP=de-latin1-nodeadkeys" > /etc/vconsole.conf

echo "${1}" > /etc/hostname
useradd $2
usermod -aG wheel $2
EDITOR=/usr/bin/vim visudo
mkdir /home/$2
chown -R "${2}":wheel /home/$2

passwd $2
passwd root

mkinitcpio -P linux
pacman -S grub efibootmgr dosfstools gptfdisk iwd dhcpcd --noconfirm
sudo systemctl enable iwd
sudo systemctl start iwd
sudo systemctl enable dhcpcd
sudo systemctl start dhcpcd
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB --recheck
grub-mkconfig -o /boot/grub/grub.cfg
