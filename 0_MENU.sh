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
normal=$a"1)"$c$h
failsafe=$a"2)"$c$h
retpoline=$a"3)"$c$h
localmodconfig=$a"4)"$c$h
stock=$a"5)"$c$h
menuconfig=$a"6)"$c$h
clean=$a"7)"$c$h
toolchain=$a"8)"$c$h
uninstall=$a"9)"$c$h
PS3=$c$h$f'

Please enter your choice:  '$c$a
echo ""
echo "        $b..:::::::$f$keffect"$d"::$f"MENU"$c$b:::::::.."
echo ""$c$h
echo "        Linux kernel source tree - modded torvalds git fork."
echo "        built with localmodconfig on llvm/clang-11..."
echo "        lld -O3 -march=native -funroll-loops mitigations=off"
echo "        polly & several optimizations used by clear linux etc."
echo "        kernel is prone towards realtime optimization and mainly for desktop. - except for option $stock".
echo "        PLUGIN ALL DEVICES PRIOR TO COMPILATION!!! - only when using options $normal, $failsafe or $retpoline."
echo "        supposed to be compiled on the hardware it is intended to run on,"
echo "        due to code optimization to local cpu and system specific auto kernel configuration."
echo "        all scripts use llvm/clang-11 for compatibility issues across dristro's."
echo "        make sure to run $toolchain installing llvm/clang-11."
echo "        this will also ensure a better binary and better performance."
echo "        as of yet this source is modded to build with clang-11+polly only."
echo "        for this reason it is$e NECESSARY!!!$c$h to run option $toolchain at least once,"
echo "        this will ensure a workaround for as of yet missing official support for polly on llvm/clang-11."
echo "        toolchain installation scripted for debian based distro's."
echo "        for ease of use every single script within this source"
echo "        comes with extensive instructions, in case of personalization or else."
echo "        also includes kernel/userspace preconfiguration."
echo "        auto compilation, installation and reboot to new kernel."
echo ""$c$a
o1=$b$i"*BUILD $keffect$b$i*$c$h
                    - regular buildscript using llvm/clang-11 toolchain.
"$c$a
o2=$b$i"*BUILD $keffect$i IN FAILSAFE MODE*$c$h
                    - use this when building with option $normal fails.
                      recommended for most people facing issues compiling.
                      (uses different paths)
"$c$a
o3=$b$i"*BUILD $keffect$i W/O RETPOLINE*$c$h
                    - build kernel with retpoline disabled,
                      may increase performance.
                      does not always boot on some hardware. worth a try.
"$c$a
o4=$b$i"*BUILD $keffect$i W/O LOCALMODCONFIG*$c$h
                    - build $kernel without using localmodconfig.
                      this will build the kernel including unused drivers.
                      use this when option $normal, $failsafe and $retpoline fail to boot.
                      (due to not auto enabling system specific drivers in localmodconfig)
                      unlike option $stock this will still ensure the custom kernels integrity.
                      this will take a long time! possibly relatively less than option $stock.
"$c$a
o5=$b$i"*BUILD STOCK KERNEL OUT OF THIS SOURCE*$c$h
                    - keep in mind this won't use localmodconfig
                      to compile system specific drivers only.
                      neither will this use $kernel configuration.
                      it will use the mainline kernel configuration instead.
                      however it will still benefit from patches applied
                      to source as well as compiler optimizations
                      and kernel/userspace preconfig which are not included in stock.
                      overall this must be bootable on every x86_64 system.
                      even for legacy, embedded devices and cpu's other than intel/amd.
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
                      making options $normal, $failsafe and $retpoline unbootable.
                      optionally enable manually for these stubborn cases.
                      or just explore the options out of curiosity.
                      remember this is an rc kernel from torvalds git,
                      proprietary drivers (if being used at all)
                      sometimes need to catch up on its development.
"$c$a
o7=$b$i"*CLEAN SOURCE*$c$h
                    - ensuring a clean build.
                      this cleans source of cache/precompiled data
                      which in some cases can be reused.
                      this should generally not be necessary.
                      avoiding this also speeds up future builds drastically.
                      only apply when facing compiler errors
                      or if you are concerned with clean builds.
"$c$a
o8=$b$i"*INSTALL LATEST LLVM/CLANG COMPILER & WORKAROUND FOR POLLY SUPPORT*$c$h
                    - as of yet llvm/clang-11 doesn't officially support polly optimizations.
                      make sure to run this option at least once to let the script take care of that.
                      ensuring the kernel is compiled with the latest compilers,
                      choose if you have issues. make sure you have the full build environment
                      and llvm/clang-11 toolchain, otherwise it's a necessity to run this prior.
                      using updated compilers can bring benefits.
                      scripted for debian based distro's.
"$c$a
o9=$b$i"*UNINSTALL KERNEL & REVERT OPTIMIZATIONS*$c$h
                    - this will automatically uninstall the kernel,
                      and its kernel/userspace preconfigurations.
                      script $uninstall also has the ability of manual input uninstallation.

"$c$e
options=("$o1" "$o2" "$o3" "$o4" "$o5" "$o6" "$o7" "$o8" "$o9" "$e$i*QUIT!*")
select opt in "${options[@]}"
do
echo -e "${restore}"
    case $opt in
        "$o1")
            echo $a"you chose option 1"
            echo $e"build starting..."
            ./1*
            ;;
        "$o2")
            echo $a"you chose option 2"
            echo $e"failsafe build starting..."
            ./2*
            ;;
        "$o3")
            echo $a"you chose option 3"
            echo $e"build without retpoline starting..."
            ./3*
            ;;
        "$o4")
            echo $a"you chose option 4"
            echo $e"build without localmodconfig starting..."
            ./4*
            ;;
        "$o5")
            echo $a"you chose option 5"
            echo $e"stock build starting..."
            ./5*
            ;;
        "$o6")
            echo $a"you chose option 6"
            echo $e"starting kernel config..."
            ./6*
            ;;
        "$o7")
            echo $a"you chose option 7"
            echo $e"cleaning sources..."
            ./7*
            ;;
        "$o8")
            echo $a"you chose option 8"
            echo $e"installing llvm/clang-11 toolchain..."
            ./8*
            ;;
        "$o9")
            echo $a"you chose option 9"
            echo $e"uninstalling kernel and linux optimizations..."
            ./9*
            ;;
        "$e$i*QUIT!*")
            break
            ;;
        *) echo $e"U high? srsly? $a$REPLY$e?!";;
    esac
done
