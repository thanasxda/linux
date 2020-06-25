#!/bin/bash
### THANAS x86-64 KERNEL - MODDED TORVALDS DEVELOPMENT FORK
### built with llvm/clang by default.
### make sure to ./install-toolchain.sh prior
### build without retpoline
###########################################################

###### SET BASH COLORS AND CONFIGURE COMPILATION TIME DISPLAY
DATE_START=$(date +"%s")
yellow="\033[1;93m"
magenta="\033[05;1;95m"
restore="\033[0m"

###### SET VARIABLES
### dirs
source="$(pwd)"
makefile=$source/Makefile
### config
defconfig=thanas_defconfig

###### UPGRADE COMPILERS PRIOR TO COMPILATION
#sudo ./upgrade.sh

###### SET UP CCACHE
export USE_CCACHE=1
export USE_PREBUILT_CACHE=1
export PREBUILT_CACHE_DIR=~/.ccache
export CCACHE_DIR=~/.ccache
ccache -M 30G

###### AUTO VERSIONING
VERSION=$(cat $makefile | head -2 | tail -1 | cut -d '=' -f2)
PATCHLEVEL=$(cat $makefile | head -3 | tail -1 | cut -d '=' -f2)
SUBLEVEL=$(cat $makefile | head -4 | tail -1 | cut -d '=' -f2)
EXTRAVERSION=$(cat $makefile | head -5 | tail -1 | cut -d '=' -f2)
VERSION=$(echo "$VERSION" | awk -v FPAT="[0-9]+" '{print $NF}')
PATCHLEVEL=$(echo "$PATCHLEVEL" | awk -v FPAT="[0-9]+" '{print $NF}')
SUBLEVEL=$(echo "$SUBLEVEL" | awk -v FPAT="[0-9]+" '{print $NF}')
EXTRAVERSION="$(echo -e "${EXTRAVERSION}" | sed -e 's/^[[:space:]]*//')"
KERNELVERSION="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}"-thanas+

###### DISPLAY KERNEL VERSION
clear
echo -e "${magenta}"
echo - THANAS X86-64 KERNEL -
echo -e "${yellow}"
make kernelversion
echo -e "${restore}"

###### COMPILER CONFIGURATION - OPTIONALLY PREBUILT COMPILER CONFIG
### set up paths in case of prebuilt compiler usage
### hash out "#clang" underneath to switch compiler from clang to gcc optionally
### if "CC=clang-10" is being used, -mllvm -polly optimizations will be enabled
### not included in clang-11 for now, due to compiler errors
##export CROSS_COMPILE=/usr/bin/x86_64-linux-gnu-
#path=/usr/bin
#path2=/usr/lib/llvm-11/bin

### set to prebuilt compiler
#xpath=~/TOOLCHAIN/clang/bin
export LD_LIBRARY_PATH=""$path2"/../lib:"$path2"/../lib64:$LD_LIBRARY_PATH"
export PATH=""$path2":$PATH"
#CLANG="CC=$xpath/clang
#        HOSTCC=$xpath/clang
#        AR=$xpath/llvm-ar
#        NM=$xpath/llvm-nm
#        OBJCOPY=$xpath/llvm-objcopy
#        OBJDUMP=$xpath/llvm-objdump
#        READELF=$xpath/llvm-readelf
#        OBJSIZE=$xpath/llvm-size
#        STRIP=$xpath/llvm-strip
#        LD=$xpath/ld.lld"

### set to system compiler
CLANG="CC=clang
        HOSTCC=clang"

#COMPILER="AR=llvm-ar
#            NM=llvm-nm
#            OBJCOPY=llvm-objcopy
#            OBJDUMP=llvm-objdump
#            READELF=llvm-readelf
#            OBJSIZE=llvm-size
#            STRIP=llvm-strip"

### optionally set linker seperately
LD="LD=ld.lld"
### enable verbose output for debugging
#VERBOSE="V=1"
### ensure all cpu threads are used for compilation
THREADS=-j$(nproc --all)

###### SETUP KERNEL CONFIG
sudo rm -rf .config
sudo rm -rf .config.old
cp $defconfig .config

ARCH="ARCH=x86_64"
SUBARCH="SUBARCH=x86_64"
export $ARCH
export $SUBARCH
Keys.ENTER | sudo make $CLANG $LD localmodconfig
### optionally modify defconfig prior to compilation
### unhash "#make menuconfig" underneath for customization
### note this is temporary since the default config gets replaced prior to each compilation
### for permanence use "./defconfig-regen.sh" and back it up because this also will be replaced but by every git pull instead
### optionally use the included "stock_defconfig" for a stock kernel configuration built on this source
### for this to function with the "build.sh" rename "stock_defconfig" and replace "thanas_defconfig" with it
#make menuconfig
### or apply "make xconfig" instead of menuconfig to configure it graphically
#make xconfig

###### DISABLE RETPOLINE
#sudo sed -i '/CONFIG_RETPOLINE/c\# CONFIG_RETPOLINE is not set' "$(pwd)"/.config

###### START COMPILATION
Keys.ENTER | sudo make $THREADS $VERBOSE $CLANG $LD
Keys.ENTER | sudo make $THREADS $VERBOSE $CLANG $LD modules

###### START AUTO INSTALLATION
### check to see if all went successfull
if [ -e $source/arch/x86/boot/vmlinux.bin ]; then
### install
sudo make $THREADS modules_install
sudo make $THREADS install
#sudo cp -v arch/x86_64/boot/bzImage /boot/vmlinuz-$KERNELVERSION
#sudo modprobe dm-mod
#sudo cp /etc/mkinitcpio.d/linux.preset /etc/mkinitcpio.d/$KERNELVERSION.preset
#sudo sed -i "s@linux@$KERNELVERSION@g" /etc/mkinitcpio.d/$KERNELVERSION.preset
#sudo mkinitcpio -p $KERNELVERSION
#cd /boot
#sudo mkinitcpio -k $KERNELVERSION -c /etc/mkinitcpio.conf -g /boot/initramfs-$KERNELVERSION.img
#sudo cp System.map /boot/System.map-$KERNELVERSION
#sudo ln -sf /boot/System.map-$KERNELVERSION /boot/System.map
###### SETTING UP SYSTEM CONFIGURATION
### set up init.sh for kernel configuration
sudo cp -v arch/x86_64/boot/bzImage /boot/vmlinuz-$KERNELVERSION
sudo mkinitcpio -k $KERNELVERSION -g /boot/initramfs-$KERNELVERSION.img
sudo cp System.map /boot/System.map-$KERNELVERSION
ln -fs /boot/System.map-$KERNELVERSION /boot/System.map
cd $source
sudo ./extras_arch.sh

###### COMPLETION
echo ...
echo ...
echo ...
echo YOU CAN REBOOT RN...
echo -e "${yellow}"
cat $source/include/generated/compile.h
echo "-------------------"
echo "Build Completed in:"
echo "-------------------"
DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo -e "${magenta}"
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo -e "${restore}"

read -p "Press Enter to reboot or Ctrl+C to cancel"

sudo reboot

### failed build scenario
else
echo -e "${yellow}"
echo "-------------------"
echo "Build failed..."
echo "-------------------"
DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo -e "${magenta}"
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo -e "${restore}"
fi;

### detect output files and ask to clean source
function clean_all {
if [ -e $source/arch/x86/boot/vmlinux.bin ]; then
cd $source && sudo make clean && sudo make mrproper
fi;
}
while read -p "Clean stuff (y/n)? " cchoice
do
case "$cchoice" in
    y|Y )
        clean_all
        echo
        echo "All Cleaned now."
        break
        ;;
    n|N )
        break
        ;;
    * )
        echo
        echo "Invalid try again!"
        echo
        ;;
esac
done
if [ -e $source/arch/x86/boot/vmlinux.bin ]; then

echo -e "${yellow}"
echo overriding option, force clean due to build success
cd $source && sudo make clean && sudo make mrproper
fi;

### reopen menu
./0*

###### END
