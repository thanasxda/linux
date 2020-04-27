#!/bin/bash
kernelname=5.7.0-rc3+
sudo cd
export USE_CCACHE=1
export USE_PREBUILT_CACHE=1
export PREBUILT_CACHE_DIR=~/.ccache
export CCACHE_DIR=~/.ccache
ccache -M 30G
THREADS=-j$(nproc --all)
#VERBOSE="V=1"
rm -rf .config
rm -rf .config.old
make localmodconfig
#make menuconfig
sudo make $THREADS $VERBOSE 
sudo make $THREADS modules
sudo make $THREADS modules_install
sudo make $THREADS install
cd /boot
sudo mkinitramfs -ko initrd.img-$kernelname $kernelname
sudo update-grub
echo YOU CAN REBOOT RN...
