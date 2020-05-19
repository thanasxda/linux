#!/bin/bash
### THANAS-x86-64-KERNEL MENU SCRIPT
yellow="\033[1;93m"
green="\033[1;32m"
restore="\033[0m"
bgr="\033[05;1;32m"
red="\033[1;91m"
blink="\033[05;1;95m"
magenta="\033[1;95m"
a=$(echo -e "${yellow}")
b=$(echo -e "${green}")
c=$(echo -e "${restore}")
d=$(echo -e "${bgr}")
e=$(echo -e "${red}")
f=$(echo -e "${blink}")
g=$(echo -e "${magenta}")
h=$(echo -e "\x1b[3m")
kernel=THANAS-x86-64-KERNEL
keffect=$g$kernel$c$b
PS3=$c'Please enter your choice: '
echo -e "${yellow}"
echo "        $b..::::::$f$keffect"$d"::$f"MENU"$c$b::::::.."
echo ""$c$h
echo "        Linux kernel source tree - modded torvalds git fork."
echo "        built with localmodconfig on llvm/clang..."
echo "        lld -O3 -march=native -funroll-loops mitigations=off (optional -polly) etc."
echo "        PLUGIN ALL DEVICES PRIOR TO COMPILATION!!! - only when using options 1), 2) or 3)."
echo "        supposed to be compiled on the hardware it is intended to run on."
echo "        auto installation/reboot to new kernel."
echo ""$c$a
o1=$b"*BUILD $keffect$b*$c$h
                    - regular buildscript using llvm/clang-11 toolchain.
"$c$a
o2=$b"*BUILD $keffect IN FAILSAFE MODE*$c$h
                    - use this when building with option 1) fails.
                      recommended for most people.
"$c$a
o3=$b"*BUILD $keffect W/O RETPOLINE*$c$h
                    - build kernel with retpoline disabled,
                      may increase performance.
                      does not always boot on some hardware.
"$c$a
o4=$b"*BUILD $keffect W/O LOCALMODCONFIG*$c$h
                    - build $kernel without using localmodconfig.
                      this will build the kernel also with drivers that will be unused.
                      use this when option 1), 2) and 3) fail.
                      unlike option 5) this will still ensure the custom kernels integrity.
                      this will take a long time! possibly relatively less than option 5).
"$c$a
o5=$b"*BUILD STOCK KERNEL OUT OF THIS SOURCE*$c$h
                    - keep in mind this won't use localmodconfig
                      to compile system specific drivers only.
                      neither will this use $kernel configuration.
                      however it will still benefit from patches applied
                      to source which are not included in stock.
                      this will take a long long time!!!
"$c$a
o6=$b"*ENTER KERNEL MENU CONFIGURATION*$c$h
                    - optionally adjust prior to build.
"$c$a
o7=$b"*CLEAN SOURCE*$c$h
                    - ensuring a clean build.
"$c$a
o8=$b"*INSTALL LATEST LLVM/CLANG COMPILERS*$c$h
                    - ensuring the kernel is compiled with the latest compilers,
                      choose if you have issues.
"$c$a
o9=$b"*UNINSTALL KERNEL & REVERT OPTIMIZATIONS*$c$h

"$c$e
options=("$o1" "$o2" "$o3" "$o4" "$o5" "$o6" "$o7" "$o8" "$o9" "Quit")
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
            echo "build without retpoline starting"
            ./3*
            ;;
        "$o4")
            echo "you chose choice 4"
            echo "build without localmodconfig starting"
            ./4*
            ;;
        "$o5")
            echo "you chose choice 5"
            echo "stock build starting"
            ./5*
            ;;
        "$o6")
            echo "you chose choice 6"
            echo "starting kernel config"
            ./6*
            ;;
        "$o7")
            echo "you chose choice 7"
            echo "cleaning sources"
            ./7*
            ;;
        "$o8")
            echo "you chose choice 8"
            echo "installing llvm/clang-11 toolchain"
            ./8*
            ;;
        "$o9")
            echo "you chose choice 9"
            echo "uninstalling kernel and linux optimizations"
            ./9*
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
