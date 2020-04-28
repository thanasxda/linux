#!/bin/bash

# Fetch kernel version from makefile -By TwistedPrime

makefile="$(pwd)/Makefile"

VERSION=$(cat $makefile | head -2 | tail -1 | cut -d '=' -f2)
PATCHLEVEL=$(cat $makefile | head -3 | tail -1 | cut -d '=' -f2)
SUBLEVEL=$(cat $makefile | head -4 | tail -1 | cut -d '=' -f2)
EXTRAVERSION=$(cat $makefile | head -5 | tail -1 | cut -d '=' -f2)
VERSION=$(echo "$VERSION" | awk -v FPAT="[0-9]+" '{print $NF}')
PATCHLEVEL=$(echo "$PATCHLEVEL" | awk -v FPAT="[0-9]+" '{print $NF}')
SUBLEVEL=$(echo "$SUBLEVEL" | awk -v FPAT="[0-9]+" '{print $NF}')
EXTRAVERSION=$(echo "$EXTRAVERSION" | awk -v FPAT="[0-9]+" '{print $NF}')

KERNELVERSION="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}"

#

sudo cd
export USE_CCACHE=1
export USE_PREBUILT_CACHE=1
export PREBUILT_CACHE_DIR=~/.ccache
export CCACHE_DIR=~/.ccache
ccache -M 30G
export KBUILD_BUILD_USER=thanas
export KBUILD_BUILD_HOST=MLX
THREADS=-j$(nproc --all)
#VERBOSE="V=1"
rm -rf .config
rm -rf .config.old
make menuconfig
make localmodconfig
sudo make $THREADS $VERBOSE 
sudo make $THREADS modules
sudo make $THREADS modules_install
sudo make $THREADS install
cd boot
sudo mkinitramfs -ko initrd.img-$KERNELVERSION $KERNELVERSION
sudo update-grub
echo YOU CAN REBOOT RN...
