#!/bin/bash
sudo cd
clear
stableconfig=thanas_defconfig
sudo rm -rf .config
sudo rm -rf .config.old
cp $stableconfig .config
### enable underneath to regenerate a system specific transposed defconfig 
#make localmodconfig
make menuconfig
cp .config $stableconfig
clear
echo DONE
