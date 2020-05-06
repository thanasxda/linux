#!/bin/bash
### built with clang
clear
### set ccache
export USE_CCACHE=1
export USE_PREBUILT_CACHE=1
export PREBUILT_CACHE_DIR=~/.ccache
export CCACHE_DIR=~/.ccache
ccache -M 30G
### set dirs
source_dir="$(pwd)"
makefile=$source_dir/Makefile
### auto versioning
VERSION=$(cat $makefile | head -2 | tail -1 | cut -d '=' -f2)
PATCHLEVEL=$(cat $makefile | head -3 | tail -1 | cut -d '=' -f2)
SUBLEVEL=$(cat $makefile | head -4 | tail -1 | cut -d '=' -f2)
EXTRAVERSION=$(cat $makefile | head -5 | tail -1 | cut -d '=' -f2)
VERSION=$(echo "$VERSION" | awk -v FPAT="[0-9]+" '{print $NF}')
PATCHLEVEL=$(echo "$PATCHLEVEL" | awk -v FPAT="[0-9]+" '{print $NF}')
SUBLEVEL=$(echo "$SUBLEVEL" | awk -v FPAT="[0-9]+" '{print $NF}')
EXTRAVERSION="$(echo -e "${EXTRAVERSION}" | sed -e 's/^[[:space:]]*//')"
KERNELVERSION="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}"-thanas+
### display kernelname
DATE_START=$(date +"%s")
yellow="\033[1;93m" 
magenta="\033[05;1;95m"
restore="\033[0m"
echo -e "${magenta}"
echo - THANAS X86-64 KERNEL - 
echo -e "${yellow}"
make kernelversion 
echo -e "${restore}"
### compiler settings & start compilation
THREADS=-j$(nproc --all)
### HASH OUT #CLANG UNDERNEATH TO BUILD WITH GCC INSTEAD
CLANG="CC=clang HOSTCC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf OBJSIZE=llvm-size STRIP=llvm-strip"
paths=/usr/bin
#LD="LD=ld.lld"
#VERBOSE="V=1"
export LD_LIBRARY_PATH="$paths/../lib:$paths/../lib64:$LD_LIBRARY_PATH"
export PATH="$paths:$PATH"
stableconfig=thanas_defconfig
sudo rm -rf .config
sudo rm -rf .config.old
cp $stableconfig .config
Keys.ENTER | make localmodconfig
#make menuconfig
Keys.ENTER | sudo make $THREADS $VERBOSE $CLANG $LD           
Keys.ENTER | sudo make $THREADS modules
Keys.ENTER | sudo make $THREADS modules_install
Keys.ENTER | sudo make $THREADS install
cd /boot
sudo mkinitramfs -ko initrd.img-$KERNELVERSION $KERNELVERSION
sudo update-grub
### set up init.sh for kernel configuration
cd $source_dir
chmod +x init.sh
sudo \cp init.sh /init.sh
sudo sed -i '1s#.*#@reboot root /init.sh#' /etc/crontab
### switch off mitigations improving linux performance
sudo sed -i '10s/.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash noibrs noibpb nopti nospectre_v2 nospectre_v1 l1tf=off nospec_store_bypass_disable no_stf_barrier mds=off spectre_v2_user=off spec_store_bypass_disable=off mitigations=off scsi_mod.use_blk_mq=1"/' /etc/default/grub
### apply grub settings
sudo update-grub
### grub auto detection
GRUB_PATH=$(sudo fdisk -l | grep '^/dev/[a-z]*[0-9]' | awk '$2 == "*"' | cut -d" " -f1 | cut -c1-8)
sudo grub-install $GRUB_PATH
### display build completion
echo ...
echo ...
echo ...
echo YOU CAN REBOOT RN...
echo -e "${yellow}"
cat $source_dir/include/generated/compile.h
echo "-------------------"
echo "Build Completed in:"
echo "-------------------"
DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo -e "${magenta}"
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo -e "${restore}"

read -p "Press Enter to reboot or Ctrl+C to cancel"

reboot

