# ARCH LINUX INSTALLATION SCRIPT

## Connect to the internet


- For Ethernet: congrats you don't have to do anything, the ethernet connection should work out of the box
- For Wifi: please type the steps below exactly like that into your terminal (program being used iwctl)
> iwctl (you will now see iwctl at the start of your command line for the commands below)
> [iwctl] station [wifi interface ex. wlan0 can be looked up using ip link] scan 
> [iwctl] station [wifi] get-networks 
> [iwctl] station [wifi] connect [SSID from the get-networks command before] 
> [iwctl] enter passphrase
> [iwctl] station [wifi] show (should show you status connected)
> [iwctl] quit

- Finally check if the ping command is working, **DONT PROCEED IF THIS IS NOT WORKING**
  (you can try systemctl restart dhcpcd, to fix possible errors)
    - ping www.google.de (**THIS MUST BE WORKING**)
    - systemctl restart dhcpcd (may take a few minutes)
    - systemctl status dhcpcd (for you in order to check if dhcpcd is active already)
<br>

## Steps to continue the installation (with boot-stick inserted)


1. First load your specific keyboard layout with loadkeys
    - loadkeys [your language ex. de]
<br>
2. Clone this repository
    - git clone https://github.com/BlackIBard/Lorenz-Arch.git
<br>
4. Now you are ready to execute the first installation script, here the base kit of Arch Linux gets installed, you can choose between BIOS or UEFI ([Archlinux](https://wiki.archlinux.org/title/installation_guide)).
**This script does completely erase all of your existing partitions on the drive you specify, SO YOU HAVE TO KNOW WHAT YOU ARE DOING!!!** 
(TODO dualboot script) 
    - ./Archlinux.sh [UEFI/BIOS] [again use fdisk -l to look for the drive you want to use, don't use the partition of a disk]
    example: ././mnt/ArchLinuxFULLAUTO/Archlinux.sh UEFI sdb

After the first script has finished, you should not see a red root text anymore, but a grey one (the script moved your root directory). 
You have to make your stick accessible to the new root directory, since the first script moved it
5. mount [Boot device directory ex. /dev/sdb1] /mnt

CONNECT TO INTERNET FIRST, ethernet or wifi, use ping www.google.de to check if dhcpcd and internet is working properly
Run second script, here the bootloader gets installed, from here on your Archlinux is installed, any further steps are optional
6. //ONLY FOR WIFI, ETHERNET CONNECTION WILL WORK OUT OF THE BOX
	-> iwctl 
	-> station [wifi interface ex. wlan0 can be looked up using ip link] scan 
	-> station [wifi] get-networks 
	-> station [wifi] connect [SSID from the get-networks command before] 
	-> enter passphrase
	-> station [wifi] show
  - ././mnt/ArchLinuxFULLAUTO/grub-install.sh

Your system should now be ready for a reboot, also you should remove the booting device, since you want to see if arch was successfully installed and is booting from your PC instead of your booting device

OPTIONAL STEPS
==

If you want to completly finish the arch installtion and don't want to bother about doing it yourself, you can just simple use the gnome-install.sh or the i3-install.sh script.
For further information on windowmanagers you can go to the arch wiki.
