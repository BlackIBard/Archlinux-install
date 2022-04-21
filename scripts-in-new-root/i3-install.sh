#!/bin/bash

sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager
sudo pacman -Sy vim wget xorg-server xorg-xinit xorg-apps i3-wm i3status xterm --noconfirm
startx /usr/bin/i3
