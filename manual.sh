#!/bin/bash
### KERNEL UNINSTALL SCRIPT
### exclusive manual kernel removal script
###########################

###### SET BASH COLORS
yellow="\033[1;93m"
magenta="\033[05;1;95m"
restore="\033[0m"

manual=*old*
manual2=*thanas*

###### KERNEL REMOVAL
sudo rm -rf /boot/vmlinuz-$manual
sudo rm -rf /boot/initrd-$manual
sudo rm -rf /boot/initrd.img-$manual
sudo rm -rf /boot/System.map-$manual
sudo rm -rf /boot/config-$manual
sudo rm -rf /lib/modules/$manual/
sudo rm -rf /var/lib/initramfs/$manual/
sudo rm -rf /var/lib/initramfs-tools/$manual

###### KERNEL REMOVAL
sudo rm -rf /boot/vmlinuz-$manual2
sudo rm -rf /boot/initrd-$manual2
sudo rm -rf /boot/initrd.img-$manual2
sudo rm -rf /boot/System.map-$manual2
sudo rm -rf /boot/config-$manual2
sudo rm -rf /lib/modules/$manual2/
sudo rm -rf /var/lib/initramfs/$manual2/
sudo rm -rf /var/lib/initramfs-tools/$manual2

###### SYSTEM OPTIMIZATION REVERSAL TO STOCK
#sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT/c\GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"' /etc/default/grub
sudo update-grub2
#GRUB_PATH=$(sudo fdisk -l | grep '^/dev/[a-z]*[0-9]' | awk '$2 == "*"' | cut -d" " -f1 | cut -c1-8)
#sudo grub-install $GRUB_PATH

###### END
