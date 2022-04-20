#!/bin/bash


echo "Connect to wifi with iwctl that will start in a second, just type 'station <interface that can be looked up with ip link> connect <SSID>' after this type in the password to your network and use ping www.google.de to check if it is working!"

iwctl


sudo systemctl start NetworkManager
ping www.google.de
sudo systemctl enable NetworkManager
sudo pacman -Syy
sudo pacman -S gnome
sudo systemctl enable gdm

