#!/bin/bash
stableconfig=thanas_defconfig
rm -rf .config
rm -rf .config.old
cp $stableconfig .config
### enable underneath to regenerate a system specific transposed defconfig 
#make localmodconfig
make menuconfig
cp .config $stableconfig
clear
echo KERNEL DEFCONFIG REGENERATED
