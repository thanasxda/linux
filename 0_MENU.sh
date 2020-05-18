#!/bin/bash
### THANAS-x86-64-KERNEL MENU SCRIPT
blink="\033[05;1;95m"
bgr="\033[05;1;32m"
red="\033[1;91m"
yellow="\033[1;93m"
green="\033[1;32m"
restore="\033[0m"
kernel=THANAS-x86-64-KERNEL
keffect=$(echo -e "${blink}")"$kernel"$(echo -e "${restore}")$(echo -e "${green}")
PS3=$(echo -e "${restore}")'Please enter your choice: '
echo -e "${yellow}"
echo "        $(echo -e "${green}")..::::::$keffect$(echo -e "${bgr}")::$(echo -e "$blink")MENU$(echo -e "${restore}")$(echo -e "${green}")::::::.."
echo ""
echo ""
echo -e "${yellow}"
o1=$(echo -e "${green}")"*BUILD $keffect$(echo -e "${green}")*$(echo -e "${restore}")
                    - regular buildscript using llvm/clang-11 toolchain.
"$(echo -e "${yellow}")
o2=$(echo -e "${green}")"*BUILD $keffect IN FAILSAFE MODE*$(echo -e "${restore}")
                    - use this when building with option 1) fails.
"$(echo -e "${yellow}")
o3=$(echo -e "${green}")"*BUILD STOCK KERNEL OUT OF THIS SOURCE*$(echo -e "${restore}")
                    - keep in mind this won't use localmodconfig
                      to compile system specific drivers only.
                      this will take a long long time!!!
"$(echo -e "${yellow}")
o4=$(echo -e "${green}")"*ENTER KERNEL MENU CONFIGURATION*$(echo -e "${restore}")
                    - optionally adjust prior to build.
"$(echo -e "${yellow}")
o5=$(echo -e "${green}")"*CLEAN SOURCE*$(echo -e "${restore}")
                    - ensuring a clean build.
"$(echo -e "${yellow}")
o6=$(echo -e "${green}")"*INSTALL LATEST LLVM/CLANG COMPILERS*$(echo -e "${restore}")
                    - ensuring the kernel is compiled with the latest compilers,
                      choose if you have issues.
"$(echo -e "${yellow}")
o7=$(echo -e "${green}")"*UNINSTALL KERNEL & REVERT OPTIMIZATIONS*

"$(echo -e "${red}")
options=("$o1" "$o2" "$o3" "$o4" "$o5" "$o6" "$o7" "Quit")
select opt in "${options[@]}"
do
echo -e "${restore}"
    case $opt in
        "$o1")
            echo "you chose choice 1"
            echo "build starting"
            ./1*
            ;;
        "$o2")
            echo "you chose choice 2"
            echo "failsafe build starting"
            ./2*
            ;;
        "$o3")
            echo "you chose choice 3"
            echo "stock build starting"
            ./3*
            ;;
        "$o4")
            echo "you chose choice 4"
            echo "starting kernel config"
            ./4*
            ;;
        "$o5")
            echo "you chose choice 5"
            echo "cleaning sources"
            ./5*
            ;;
        "$o6")
            echo "you chose choice 6"
            echo "installing llvm/clang-11 toolchain"
            ./6*
            ;;
        "$o7")
            echo "you chose choice 7"
            echo "uninstalling kernel and linux optimizations"
            ./7*
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
