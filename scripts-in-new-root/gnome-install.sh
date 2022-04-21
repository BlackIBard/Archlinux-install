#!/bin/bash

sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager
sudo pacman -Syy gnome --noconfirm
sudo systemctl enable gdm

