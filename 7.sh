#!/bin/bash
### CLEAN SOURCE SCRIPT - use when facing issues
#####################################################################################

###### SET BASH COLORS
yellow="\033[1;93m"
magenta="\033[05;1;95m"
restore="\033[0m"

echo -e "${magenta}"
echo Cleaning started
echo -e "${restore}"

###### CLEAN
sudo make clean && sudo make mrproper

###### COMPLETION
echo -e "${yellow}"
echo Source cleaned
echo -e "${restore}"
sleep 2
clear

### reopen menu
./0*

###### END
