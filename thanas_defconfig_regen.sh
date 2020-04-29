#!/bin/bash
sudo cd
clear
CLANG="CC=clang HOSTCC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf OBJSIZE=llvm-size STRIP=llvm-strip"
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
