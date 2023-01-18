#!/usr/bin/zsh
### KERNEL UNINSTALL SCRIPT
### exclusive manual kernel removal script
###########################

###### SET BASH COLORS
yellow="\033[1;93m"
magenta="\033[05;1;95m"
restore="\033[0m"


###### KERNEL REMOVAL
for i in *thanas* ; do
sudo rm -rf /boot/vmlinuz-$i
sudo rm -rf /boot/initrd-$i
sudo rm -rf /boot/initrd.img-$i
sudo rm -rf /boot/System.map-$i
sudo rm -rf /boot/config-$i
sudo rm -rf /lib/modules/$i/
sudo rm -rf /var/lib/initramfs/$i/
sudo rm -rf /var/lib/initramfs-tools/$i
sudo rm -rf /boot/efi/loader/entries/$i
for a in $(find /boot/efi -type l) ; do
sudo rm -rf $a/$i ; done
done

###### SYSTEM OPTIMIZATION REVERSAL TO STOCK
#sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT/c\GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"' /etc/default/grub
sudo update-grub2
#GRUB_PATH=$(sudo fdisk -l | grep '^/dev/[a-z]*[0-9]' | awk '$2 == "*"' | cut -d" " -f1 | cut -c1-8)
#sudo grub-install $GRUB_PATH

###### END
