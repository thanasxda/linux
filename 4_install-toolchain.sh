#!/bin/bash
### FETCH LATEST COMPILERS
### built with llvm/clang by default
###########################################################

###### SET BASH COLORS
yellow="\033[1;93m"
magenta="\033[05;1;95m"
restore="\033[0m"

###### UPGRADE COMPILERS PRIOR TO COMPILATION
echo -e "${yellow}"
echo "Adding llvm-11 repository"
echo "and upgrading system compilers"
echo -e "${restore}"

### daily llvm git builds - not always support for lto
### DO NOT change distro on the llvm repos. these branches are only meant for the toolchain
### and will ensure you will always use latest llvm when using "make CC=clang"
llvm_1='deb http://apt.llvm.org/focal/ llvm-toolchain-focal main'
llvm_2='deb-src http://apt.llvm.org/focal/ llvm-toolchain-focal main'
new_sources=("$llvm_1" "$llvm_2")
for i in ${!new_sources[@]}; do
    if ! grep -q "${new_sources[$i]}" /etc/apt/sources.list; then
        echo "${new_sources[$i]}" | sudo tee -a /etc/apt/sources.list
        echo "Added ${new_sources[$i]} to source list"
        ### fetch keys llvm git
        wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
    fi
done
### upgrade compilers
sudo apt update
sudo apt -f upgrade -y clang-11 lld-11
sudo apt -f upgrade -y gcc-10 clang-10 lld-10
sudo apt -f upgrade -y gcc clang binutils make flex bison bc build-essential libncurses-dev  libssl-dev libelf-dev qt5-default

### completion
echo -e "${magenta}"
echo "llvm-11 installed and the rest of the toolchain updated!"
echo -e "${restore}"

###### END
