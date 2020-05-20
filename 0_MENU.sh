#!/bin/bash
### THANAS-x86-64-KERNEL MENU SCRIPT
yellow="\033[1;93m"
green="\033[1;32m"
restore="\033[0m"
bgr="\033[05;1;32m"
red="\033[1;91m"
blink="\033[05;1;95m"
magenta="\033[1;95m"
italic="\x1b[3m"
underline="\e[4m"
a=$(echo -e "${yellow}")
b=$(echo -e "${green}")
c=$(echo -e "${restore}")
d=$(echo -e "${bgr}")
e=$(echo -e "${red}")
f=$(echo -e "${blink}")
g=$(echo -e "${magenta}")
h=$(echo -e "${italic}")
i=$(echo -e "${underline}")
kernel=THANAS-x86-64-KERNEL
keffect=$g$kernel$c$b
PS3=$c$h$f'

Please enter your choice: '
echo ""
echo "        $b..::::::$f$keffect"$d"::$f"MENU"$c$b::::::.."
echo ""$c$h
echo "        Linux kernel source tree - modded torvalds git fork."
echo "        built with localmodconfig on llvm/clang..."
echo "        lld -O3 -march=native -funroll-loops mitigations=off"
echo "        and clear linux optimizations (optional -polly) etc."
echo "        PLUGIN ALL DEVICES PRIOR TO COMPILATION!!! - only when using options 1), 2) or 3)."
echo "        supposed to be compiled on the hardware it is intended to run on,"
echo "        due to code optimization to local cpu and system specific auto kernel configuration."
echo "        all scripts use llvm/clang-11 for compatibility issues across dristros."
echo "        make sure to run 8) installing llvm/clang-11 if you don't have it."
echo "        this will also ensure a better binary and more performance."
echo "        comes with kernel/userspace preconfiguration."
echo "        auto installation/reboot to new kernel."
echo ""$c$a
o1=$b$i"*BUILD $keffect$b$i*$c$h
                    - regular buildscript using llvm/clang-11 toolchain.
"$c$a
o2=$b$i"*BUILD $keffect$i IN FAILSAFE MODE*$c$h
                    - use this when building with option 1) fails.
                      recommended for most people who face issues compiling.
"$c$a
o3=$b$i"*BUILD $keffect$i W/O RETPOLINE*$c$h
                    - build kernel with retpoline disabled,
                      may increase performance.
                      does not always boot on some hardware. worth a try.
"$c$a
o4=$b$i"*BUILD $keffect$i W/O LOCALMODCONFIG*$c$h
                    - build $kernel without using localmodconfig.
                      this will build the kernel also with drivers that will be unused.
                      use this when option 1), 2) and 3) fail to boot.
                      unlike option 5) this will still ensure the custom kernels integrity.
                      this will take a long time! possibly relatively less than option 5).
"$c$a
o5=$b$i"*BUILD STOCK KERNEL OUT OF THIS SOURCE*$c$h
                    - keep in mind this won't use localmodconfig
                      to compile system specific drivers only.
                      neither will this use $kernel configuration.
                      however it will still benefit from patches applied
                      to source which are not included in stock.
                      overall this must be bootable on every x86_64 system.
                      do not expect the same performance as the options above.
                      this will take a long long time!!!
"$c$a
o6=$b$i"*ENTER KERNEL MENU CONFIGURATION*$c$h
                    - optionally adjust prior to build.
                      navigate the menu of the linux kernel.
                      use '?' to get a description of every option,
                      or open 'thanas_defconfig' and head over to
                      https://cateee.net/lkddb/web-lkddb/ for descriptions.
                      rare cases when using localmodconfig,
                      certain drivers are not auto enabled thus,
                      making options 1), 2) and 3) unbootable.
                      optionally enable manually for these stubborn cases.
"$c$a
o7=$b$i"*CLEAN SOURCE*$c$h
                    - ensuring a clean build.
                      this should generally not be necessary.
                      avoiding this also speeds up future builds drastically.
                      only apply when facing compiler errors.
"$c$a
o8=$b$i"*INSTALL LATEST LLVM/CLANG COMPILERS*$c$h
                    - ensuring the kernel is compiled with the latest compilers,
                      choose if you have issues. make sure you have llvm/clang-11 toolchain,
                      otherwise its a necessity to run this prior.
"$c$a
o9=$b$i"*UNINSTALL KERNEL & REVERT OPTIMIZATIONS*$c$h
                    - this will automatically uninstall the kernel,
                      and it's kernel/userspace preconfigurations.

"$c$e
options=("$o1" "$o2" "$o3" "$o4" "$o5" "$o6" "$o7" "$o8" "$o9" "$e$i*QUIT*")
select opt in "${options[@]}"
do
echo -e "${restore}"
    case $opt in
        "$o1")
            echo $a"you chose choice 1"
            echo $e"build starting"
            ./1*
            ;;
        "$o2")
            echo $a"you chose choice 2"
            echo $e"failsafe build starting"
            ./2*
            ;;
        "$o3")
            echo $a"you chose choice 3"
            echo $e"build without retpoline starting"
            ./3*
            ;;
        "$o4")
            echo $a"you chose choice 4"
            echo $e"build without localmodconfig starting"
            ./4*
            ;;
        "$o5")
            echo $a"you chose choice 5"
            echo $e"stock build starting"
            ./5*
            ;;
        "$o6")
            echo $a"you chose choice 6"
            echo $e"starting kernel config"
            ./6*
            ;;
        "$o7")
            echo $a"you chose choice 7"
            echo $e"cleaning sources"
            ./7*
            ;;
        "$o8")
            echo $a"you chose choice 8"
            echo $e"installing llvm/clang-11 toolchain"
            ./8*
            ;;
        "$o9")
            echo $a"you chose choice 9"
            echo $e"uninstalling kernel and linux optimizations"
            ./9*
            ;;
        "$e$i*QUIT*")
            break
            ;;
        *) echo $e"U high? srsly? $a$REPLY$e?";;
    esac
done
