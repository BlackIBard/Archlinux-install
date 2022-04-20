#!/bin/bash

sudo systemctl start NetworkManager
ping www.google.de
sudo systemctl enable NetworkManager
sudo pacman -Syy
sudo pacman -S gnome
sudo systemctl enable gdm

