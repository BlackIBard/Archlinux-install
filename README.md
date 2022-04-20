ARCH LINUX INSTALLATION SCRIPT
=============================================================================================================

First load your specific keyboard layout with loadkeys, then connect your device to the internet, assuming you are using wifi
1. loadkeys de 
   //ONLY FOR WIFI, ETHERNET CONNECTION WILL WORK OUT OF THE BOX
	-> iwctl 
	-> station [wifi interface ex. wlan0 can be looked up using ip link] scan 
	-> station [wifi] get-networks 
	-> station [wifi] connect [SSID from the get-networks command before] 
	-> enter passphrase
	-> station [wifi] show

Now use fdisk -l to search for your usb drive (in virtualbox you got to insert the stick manually in the options, in vmware a message should pop up when your usb drive is plugged into your computer, 
if your installing Arch directly on your pc, the usb drive will be recognized automatically), with mount you make the drive accessible
2. fdisk -l (in the tables, your usb drive most of the time is named /dev/sdb1 or /dev/sdc1) 
	-> mount [Boot device directory ex. /dev/sdb1] /mnt

cd to the "root" directory
3. cd .. (or cd /)

First off check if the ping command is working, DONT PROCEED IF IT IS NOT WORKING, instead try systemctl restart dhcpcd
Now you are ready to execute the first installation script, here the base kit of Arch Linux gets installed, you can choose between BIOS or UEFI, if you are not sure what these two are, read it up in the Archlinux wiki
also this script does completely erase all of your existing partitions on the drive you specify, SO YOU HAVE TO KNOW WHAT YOU ARE DOING!!! (TODO dualboot script)
4. ping www.google.de 
	-> ././mnt/ArchLinuxFULLAUTO/Archlinux.sh [UEFI/BIOS] [again use fdisk -l to look for the drive you want to use, don't use the partition of a disk]

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
=============================================================================================================

If you want to completly finish the arch installtion and don't want to bother about doing it yourself, you can just simple use the gnome-install.sh or the i3-install.sh script.
For further information on windowmanagers you can go to the arch wiki.
