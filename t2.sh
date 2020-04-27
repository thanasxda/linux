#!/bin/bash
kernelname=5.7.0-rc3+
sudo cd
export USE_CCACHE=1
export USE_PREBUILT_CACHE=1
export PREBUILT_CACHE_DIR=~/.ccache
export CCACHE_DIR=~/.ccache
ccache -M 30G
THREADS=-j$(nproc --all)
CLANG="CC=clang HOSTCC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf OBJSIZE=llvm-size STRIP=llvm-strip"
#VERBOSE="V=1"
stableconfig=config-5.6.7-050607-generic
sudo rm -rf .config
sudo rm -rf .config.old
cp /boot/$stableconfig .config
make localmodconfig
#make menuconfig
sudo make $THREADS $VERBOSE $CLANG            
sudo make $THREADS modules
sudo make $THREADS modules_install
sudo make $THREADS install
cd /boot
sudo mkinitramfs -ko initrd.img-$kernelname $kernelname
sudo update-grub
echo YOU CAN REBOOT RN...
