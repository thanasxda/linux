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
#CLANGP=~/TOOLCHAIN/clang
#LD="LD=ld.lld"
#VERBOSE="V=1"
#export LD_LIBRARY_PATH="$CLANGP/../lib:$CLANGP/../lib64:$LD_LIBRARY_PATH"
#export PATH="$CLANGP:$PATH"
stableconfig=thanas_defconfig
sudo rm -rf .config
sudo rm -rf .config.old
cp $stableconfig .config
make localmodconfig
#make menuconfig
sudo make $THREADS $VERBOSE $CLANG $LD           
sudo make $THREADS modules
sudo make $THREADS modules_install
sudo make $THREADS install
cd /boot
sudo mkinitramfs -ko initrd.img-$KERNELVERSION $KERNELVERSION
sudo update-grub
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

