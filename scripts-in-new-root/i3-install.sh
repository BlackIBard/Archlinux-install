#!/bin/bash

systemctl start dhcpcd
pacman -Sy
pacman -S vim
pacman -S wget
pacman -S rofi
pacman -S xorg-xinit
pacman -S xorg-server xorg-xinit
pacman -S xorg-apps
pacman -S i3-wm
pacman -S i3status
pacman -S xterm
pacman -S neofetch
pacman -S nemo
pacman -S dconf
pacman -S vte3
pacman -S st

startx /usr/bin/i3
