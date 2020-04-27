#!/bin/bash
kernelname=5.7.0-rc3+

K1=$kernelname
K2=$kernelname.old
sudo cd
sudo rm -rf /boot/vmlinuz-$K1
sudo rm -rf /boot/initrd-$K1
sudo rm -rf /boot/System-map-$K1
sudo rm -rf /boot/config-$K1
sudo rm -rf /lib/modules/$K1/
sudo rm -rf /var/lib/initramfs/$K1/
sudo rm -rf /boot/vmlinuz-$K2
sudo rm -rf /boot/initrd-$K2
sudo rm -rf /boot/System-map-$K2
sudo rm -rf /boot/config-$K2
sudo rm -rf /lib/modules/$K2/
sudo rm -rf /var/lib/initramfs/$K2/
sudo update-grub
