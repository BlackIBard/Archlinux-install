# Archlinux installation script (how to use)

## Connect to the internet

1. First load your specific keyboard layout with loadkeys

```
  > loadkeys [your language ex. de]
```

2. For Ethernet: congrats you don't have to do anything, the ethernet connection should work out of the box

3. For Wifi: please type the steps below exactly like that into your terminal (program being used iwctl)

```
  > iwctl (you will now see iwctl at the start of your command line for the commands below)
  [iwd]# station [wifi interface ex. wlan0 can be looked up using ip link] scan 
  [iwd]# station [wifi] get-networks 
  [iwd]# station [wifi] connect [SSID from the get-networks command before] 
  [iwd]# enter passphrase
  [iwd]# station [wifi] show (should show you status connected)
  [iwd]# quit
```

4. Finally check if the ping command is working, **DONT PROCEED IF THIS IS NOT WORKING**
  (you can try systemctl restart dhcpcd, to fix possible errors)

```
  > ping www.google.de (**THIS MUST BE WORKING**)
```

- In case of an error you can try the following

```
  > systemctl restart dhcpcd (may take a few minutes)
  > systemctl status dhcpcd (for you in order to check if dhcpcd is active already)
```

---

## Steps to continue the installation (with boot-stick inserted)```

1. Install git and clone this repository and cd into it
```
  > pacman -Sy git (always just press enter if it asks you for anything)
  > git clone https://github.com/BlackIBard/Lorenz-Arch.git
  > cd Lorenz-Arch
```

2. Now you are ready to execute the first installation script, here the base kit of Arch Linux gets installed, you can choose between BIOS or UEFI ([Archlinux](https://wiki.archlinux.org/title/installation_guide)). After you have chosen your bootmode, continue with to lookup the drive, on which you want to install your Archlinux.
**This script does completely erase all of your existing partitions on the drive you specify, SO YOU HAVE TO KNOW WHAT YOU ARE DOING!!!** (TODO dualboot script)

```
  > ./Archlinux.sh [UEFI/BIOS] [use fdisk -l to look for the drive you want to use, don't use the partition of a disk]
```

- example: 

```
  > ./Archlinux.sh UEFI /dev/sdb
```

- after the script finished, you should not see a red root text anymore, but a grey one, this is because your root has been moved


3. Again follow the steps from section [connect to the internet](#connect-to-the-internet) and only continue if the ping command succeeds.

4. Change your current directory to "scripts-in-new-root". 
Afterwards run the second script, this installs your bootloader so your machine can boot into linux, without boot drive. The script will ask you for a hostname, an username and a password for that user. The hostname specifies the name of your PC, the username specifies the name of your user, which you will be using for future logins. When the scripts asks you for a password, it will first ask for your user with username, then for the root user. In a part of the script you will see blue text with # at the beginning, this is the language file, where you can define, which language you want for your Archlinux to have, you do that by removing the # before the language you chose. Afterwards you will again see this blue text, there you have to remove the # before the wheel:wheel All ... entry. After the script finished, use exit to return to the red root text, here you are able to shutdown or reboot the machine.
**BE CAREFUL TO REMEMBER YOUR USERNAME, YOUR PASSWORD AND THE PASSWORD FOR THE ROOT USER.**

```
  > cd scripts-in-new-root
  > ./grub-install.sh [some hostname, can be anything] [username, again can be anything]
  > exit
```

5. Your system should now be ready for a shutdown or a reboot, also you should **remove the booting device**, since you want to see if arch was successfully installed and is booting from your machine. Use **one** of the following:
```
  > shutdown now
```

  - **OR**

```
  > reboot
```

<br>

# Optional Steps (no booting device needed)

- If you want to completely finish the arch installation and don't want to bother about doing it yourself, you can just simple use the gnome-install.sh, the i3-install.sh script, or my i3-install-with-my-config.sh script, which will be in the scripts-in-new-root folder, in your root directory. 
**Important: Follow the steps of [connecting to the internet](#connect-to-the-internet) to connect to the internet, or at least the ping command must succeed.**

```
> cd /scripts-in-new-root
> ./gnome-install.sh
```

- **OR**

```
> cd /scripts-in-new-root
> ./i3-install.sh
```

- **OR**

```
> cd /scripts-in-new-root
> ./i3-install-with-my-config.sh
```


- For further information about windowmanagers you can use the [Archwiki](https://wiki.archlinux.org/title/window_manager).
