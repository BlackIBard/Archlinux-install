#!/bin/bash

arg1=$1
partF=0
i=1

if [[ $1 != "UEFI" ]] && [[ $1 != "BIOS" ]]; then
  echo "No firmware interface (UEFI/BIOS) has been specified!"
  exit 0
fi

for file in `lsblk -d -o NAME -n -p`; do
  if [[ $file == $2 ]]; then
    partF=1
  fi;
done

if [ $partF == 0 ]; then
  echo "No partition has been specified, or the specified partition could not be found, please use a partition from lsblk!"
  exit 0
fi

while : ; do
    parted $2 rm $i -s
    RESULT=$?
    if [ $RESULT = 1 ]; then
      break
    fi
    let i=i+1;
done

if [[ $arg1 == "UEFI" ]]; then
  # UEFI/GPT
  echo "uefi test"
  parted $2 mktable gpt -s
  parted $2 mkpart primary fat32 1MiB 513MiB -s

  if [[ $2 == *"sd"* ]]; then
    parted $2 select ${2}1 -s
    parted $2 set 1 esp on -s
    parted $2 mkpart primary fat32 513MiB 100% -s
    mkfs.ext4 ${2}2
    mount ${2}2 /mnt
    mkdir /mnt/efi
    mount ${2}1 /mnt/efi
  elif [[ $2 == *"nvme"* ]]; then
    parted $2 select /dev/${2}p1 -s
    parted $2 set 1 esp on -s
    parted $2 mkpart primary fat32 513MiB 100% -s
    mkfs.ext4 ${2}p2
    mount ${2}p2 /mnt
    mkdir /mnt/efi
    mount ${2}p1 /mnt/efi
  fi
  
  
elif [[ $arg1 == "BIOS" ]]; then
  # BIOS/MBR
  echo "bios test"
  #parted /dev/nvme0n1 mktable msdos
  #parted /dev/nvme0n1 mkpart primary ext4 1MiB 20GiB
  #parted /dev/nvme0n1 select /dev/nvme0n1p1
  #parted /dev/nvme0n1 set 1 boot on
  #mount /dev/nvme0n1p1 /mnt
fi

cp scripts-in-new-root /mnt -r
pacman -Sy
pacstrap /mnt base base-devel linux linux-firmware vim networkmanager man-db man-pages iwd dhcpcd
genfstab -U /mnt >>/mnt/etc/fstab
arch-chroot /mnt
