#!/bin/bash
### REGENERATION SCRIPT FOR "thanas_defconfig" OPTIONALLY RUN TO CHANGE CONFIGURATION
#####################################################################################

### KERNEL DEFCONFIG SELECTION
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
make menuconfig
cp .config $stableconfig
clear
echo KERNEL DEFCONFIG REGENERATED

### END
