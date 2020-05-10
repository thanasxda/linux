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
#stableconfig=stock_defoncfig
stableconfig=thanas_defconfig
rm -rf .config
rm -rf .config.old
cp $stableconfig .config

### unhash "#make localmodconfig" underneath to regenerate a system specific transposed defconfig
### note that this will be specialized for your current hardware ONLY
#make localmodconfig

### enter kernel configuration. optionally apply changes and press save
### the newly generated config will replace "thanas_defconfig" by default!
### optionally replace "make menuconfig" with "make xconfig" for a graphical approach
### compiler used CC=clang - as to show up correctly
#make CC=clang xconfig
make CC=clang menuconfig
cp .config $stableconfig

###### COMPLETION
clear
echo -e "${yellow}"
echo KERNEL DEFCONFIG REGENERATED
echo -e "${restore}"

###### END
