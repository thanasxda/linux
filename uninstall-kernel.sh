#!/bin/bash
sudo cd
clear

makefile="$(pwd)/Makefile"

VERSION=$(cat $makefile | head -2 | tail -1 | cut -d '=' -f2)
PATCHLEVEL=$(cat $makefile | head -3 | tail -1 | cut -d '=' -f2)
SUBLEVEL=$(cat $makefile | head -4 | tail -1 | cut -d '=' -f2)
EXTRAVERSION=$(cat $makefile | head -5 | tail -1 | cut -d '=' -f2)
VERSION=$(echo "$VERSION" | awk -v FPAT="[0-9]+" '{print $NF}')
PATCHLEVEL=$(echo "$PATCHLEVEL" | awk -v FPAT="[0-9]+" '{print $NF}')
SUBLEVEL=$(echo "$SUBLEVEL" | awk -v FPAT="[0-9]+" '{print $NF}')
EXTRAVERSION="$(echo -e "${EXTRAVERSION}" | sed -e 's/^[[:space:]]*//')"

KERNELVERSION="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}"

K1=$KERNELVERSION-*
K2=$KERNELVERSION+*

sudo rm -rf /boot/vmlinuz-$K1
sudo rm -rf /boot/initrd-$K1
sudo rm -rf /boot/initrd.img-$K1
sudo rm -rf /boot/System.map-$K1
sudo rm -rf /boot/config-$K1
sudo rm -rf /lib/modules/$K1/
sudo rm -rf /var/lib/initramfs/$K1/
sudo rm -rf /var/lib/initramfs-tools/$K1
sudo rm -rf /boot/vmlinuz-$K2
sudo rm -rf /boot/initrd-$K2
sudo rm -rf /boot/initrd.img-$K2
sudo rm -rf /boot/System.map-$K2
sudo rm -rf /boot/config-$K2
sudo rm -rf /lib/modules/$K2/
sudo rm -rf /var/lib/initramfs/$K2/
sudo rm -rf /var/lib/initramfs-tools/$K1
sudo update-grub
