#!/bin/bash
### REGENERATION SCRIPT FOR "thanas_defconfig" OPTIONALLY RUN TO CHANGE CONFIGURATION
#####################################################################################

###### SET BASH COLORS
yellow="\033[1;93m"
magenta="\033[05;1;95m"
restore="\033[0m"

echo -e "${magenta}"
echo OPENING UP KERNEL CONFIGURATION
echo -e "${restore}"

###### KERNEL DEFCONFIG SELECTION
#defconfig=stock_defconfig
#defconfig=kali_defconfig
defconfig=thanas_defconfig
rm -rf .config
rm -rf .config.old
cp $defconfig .config

### unhash "#make localmodconfig" underneath to regenerate a system specific transposed defconfig
### note that this will be specialized for your current hardware ONLY
#make localmodconfig

### enter kernel configuration. optionally apply changes and press save
### the newly generated config will replace "thanas_defconfig" by default!
### optionally replace "make menuconfig" with "make xconfig" for a graphical approach
### compiler used CC=clang - as to show up correctly
#make CC=clang xconfig
### getting issues on other distros, for now using failsafe methods. normally not needed.
#path=/usr/bin
#path2=/usr/lib/llvm-11/bin
#xpath=~/TOOLCHAIN/clang/bin
#export LD_LIBRARY_PATH=""$path2"/../lib:"$path2"/../lib64:$LD_LIBRARY_PATH"
#export PATH=""$path2":$PATH"
#CLANG="CC=$path/clang
#        HOSTCC=$path/clang"
#LD="LD=$path/ld.lld"
sudo make $CLANG $LD menuconfig
cp .config $defconfig

###### COMPLETION
clear
echo -e "${yellow}"
echo KERNEL DEFCONFIG REGENERATED
echo -e "${restore}"
sleep 2
clear

### reopen menu
./0*

###### END
