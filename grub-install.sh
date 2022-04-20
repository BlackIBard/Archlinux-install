#!/bin/bash

echo "Specify PC hostname:"

read HOSTNAME

if [[ $HOSTNAME == "" ]]; then
	echo "You have to specify a hostname for your machine!"
	exit 0
fi

echo "Username:"

read USERNAME
passwd $USERNAME

if [[ $USERNAME == "" ]]; then
	echo "You have to enter a username!"
	exit 0
fi


ln -s /usr/share/zoneinfo/Europa/Vienna /etc/localtime
vim /etc/locale.gen
locale-gen
echo "LANG=de_DE.UTF-8" > /etc/locale.conf
echo "KEYMAP=de-latin1-nodeadkeys" > /etc/vconsole.conf
echo "${HOSTNAME}" > /etc/hostname
useradd $USERNAME
usermod -aG wheel $USERNAME
EDITOR=/usr/bin/vim visudo
mkdir /home/$USERNAME
chown -R "${USERNAME}":wheel /home/$USERNAME

mkinitcpio -P linux
pacman -S grub efibootmgr dosfstools gptfdisk iwd dhcpcd
sudo systemctl enable iwd
sudo systemctl start iwd
sudo systemctl enable dhcpcd
sudo systemctl start dhcpcd
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB --recheck
grub-mkconfig -o /boot/grub/grub.cfg
