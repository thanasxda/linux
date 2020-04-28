#!/bin/bash
sudo cd
sudo rm -rf .config
sudo rm -rf .config.old
cp stock_defconfig .config
make localmodconfig
#make menuconfig
