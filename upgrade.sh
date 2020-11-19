#!/bin/bash
### THANAS x86-64 KERNEL - MODDED TORVALDS DEVELOPMENT FORK

###### UPGRADE COMPILERS PRIOR TO COMPILATION
yellow="\033[1;93m"
magenta="\033[05;1;95m"
restore="\033[0m"
echo -e "${yellow}"
echo "UPDATING CURRENT COMPILERS PRIOR TO INSTALLATION"
echo "ENSURING THE KERNEL IS ALWAYS BUILT WITH THE LATEST COMPILERS"
echo -e "${restore}"
sudo apt update
sudo apt -f install -y aptitude
sudo aptitude -f install -y libomp-12-dev llvm-12 llvm clang-12 lld-12 gcc clang binutils make flex bison bc build-essential libncurses-dev libssl-dev libelf-dev qt5-default libclang-common-12-dev
