#!/bin/bash
### KERNEL UNINSTALL SCRIPT
###########################

###### SET BASH COLORS
yellow="\033[1;93m"
magenta="\033[05;1;95m"
restore="\033[0m"

###### DETECT CURRENT PATCHLEVEL VERSIONING ONLY - for safety
makefile="$(pwd)/Makefile"

VERSION=$(cat $makefile | head -2 | tail -1 | cut -d '=' -f2)
PATCHLEVEL=$(cat $makefile | head -3 | tail -1 | cut -d '=' -f2)
SUBLEVEL=$(cat $makefile | head -4 | tail -1 | cut -d '=' -f2)
EXTRAVERSION=$(cat $makefile | head -5 | tail -1 | cut -d '=' -f2)
VERSION=$(echo "$VERSION" | awk -v FPAT="[0-9]+" '{print $NF}')
PATCHLEVEL=$(echo "$PATCHLEVEL" | awk -v FPAT="[0-9]+" '{print $NF}')
SUBLEVEL=$(echo "$SUBLEVEL" | awk -v FPAT="[0-9]+" '{print $NF}')
#EXTRAVERSION="$(echo -e "${EXTRAVERSION}" | sed -e 's/^[[:space:]]*//')"
#KERNELVERSION="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}"
### hash out if removing manually
RC_KERNEL="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}"-rc*

### for deletion of a specific version or older than current version
### input kernelname into one of the "manual='name_here*'" underneath
### note that the usage of * will remove any kernel starting with that name
manual=5.7.0-rc*

echo -e "${magenta}"
echo REMOVING ALL INSTALLED RELEASE CANDIDATE WITH VESIONING $RC_KERNEL KERNELS FOUND ON THE SYSTEM VERSIONS!
echo -e "${yellow}"
echo for safety avoiding removing any stock kernels open the "/uninstall-kernel.sh" script and insert your previous patchlevel manually if needed under "manual='name_here'"
echo TO AVOID ISSUES UNINSTALL THE KENELS WHILE RUNNING ON A KERNEL THAT WILL NOT BE REMOVED BY THIS SCRIPT!!!
echo -e "${restore}"

###### KERNEL REMOVAL
sudo rm -rf /boot/vmlinuz-$RC_KERNEL
sudo rm -rf /boot/initrd-$RC_KERNEL
sudo rm -rf /boot/initrd.img-$RC_KERNEL
sudo rm -rf /boot/System.map-$RC_KERNEL
sudo rm -rf /boot/config-$RC_KERNEL
sudo rm -rf /lib/modules/$RC_KERNEL/
sudo rm -rf /var/lib/initramfs/$RC_KERNEL/
sudo rm -rf /var/lib/initramfs-tools/$RC_KERNEL

sudo rm -rf /boot/vmlinuz-$manual
sudo rm -rf /boot/initrd-$manual
sudo rm -rf /boot/initrd.img-$manual
sudo rm -rf /boot/System.map-$manual
sudo rm -rf /boot/config-$manual
sudo rm -rf /lib/modules/$manual/
sudo rm -rf /var/lib/initramfs/$manual/
sudo rm -rf /var/lib/initramfs-tools/$manual

###### INIT.SH KERNEL PRECONFIG SCRIPT REMOVAL
sudo rm -rf /init.sh

###### SYSTEM OPTIMIZATION REVERSAL TO STOCK
sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT/c\GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"' /etc/default/grub
sudo update-grub2
GRUB_PATH=$(sudo fdisk -l | grep '^/dev/[a-z]*[0-9]' | awk '$2 == "*"' | cut -d" " -f1 | cut -c1-8)
sudo grub-install $GRUB_PATH

###### COMPLETION
echo -e "${yellow}"
echo ...
echo ...
echo ...
echo ALL $RC_KERNEL KERNELS UNINSTALLED AND ALL OPTIMIZATIONS REVERTED
echo -e "${restore}"

read -p "Press Enter to reboot or Ctrl+C to cancel"

sudo reboot
sleep 2
clear

### reopen menu
./0*

###### END
