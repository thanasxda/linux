#!/bin/bash
### THANAS-x86-64-KERNEL MENU SCRIPT
blink="\033[05;1;95m"
bgr="\033[05;1;32m"
red="\033[1;91m"
yellow="\033[1;93m"
green="\033[1;32m"
restore="\033[0m"
a=$(echo -e "${yellow}")
b=$(echo -e "${green}")
c=$(echo -e "${restore}")
d=$(echo -e "${bgr}")
kernel=THANAS-x86-64-KERNEL
keffect=$(echo -e "${blink}")"$kernel"$c$b
PS3=$c'Please enter your choice: '
echo -e "${yellow}"
echo "        $b..::::::$keffect$d::$(echo -e "$blink")MENU$c$b::::::.."
echo ""
echo ""
echo -e "${yellow}"
o1=$b"*BUILD $keffect$b*$c
                    - regular buildscript using llvm/clang-11 toolchain.
"$a
o2=$b"*BUILD $keffect IN FAILSAFE MODE*$c
                    - use this when building with option 1) fails.
"$a
o3=$b"*BUILD STOCK KERNEL OUT OF THIS SOURCE*$c
                    - keep in mind this won't use localmodconfig
                      to compile system specific drivers only.
                      this will take a long long time!!!
"$a
o4=$b"*ENTER KERNEL MENU CONFIGURATION*$c
                    - optionally adjust prior to build.
"$a
o5=$b"*CLEAN SOURCE*$c
                    - ensuring a clean build.
"$a
o6=$b"*INSTALL LATEST LLVM/CLANG COMPILERS*$c
                    - ensuring the kernel is compiled with the latest compilers,
                      choose if you have issues.
"$a
o7=$b"*UNINSTALL KERNEL & REVERT OPTIMIZATIONS*

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
