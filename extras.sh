#!/bin/bash

### variables
source="$(pwd)"
yellow="\033[1;93m"
magenta="\033[05;1;95m"
restore="\033[0m"

echo -e "${yellow}"
echo "setting up userspace kernel configuration & system optimizations"
echo "on root filesystem /init.sh can be found, adjust it to your needs"
echo "these will be removed once the uninstall script has been executed"
echo -e "${restore}"
cd $source
chmod +x init.sh
sudo \cp init.sh /init.sh
if grep -q "@reboot root /init.sh" /etc/crontab
then
echo "Flag exists"
else
sudo sed -i "\$a@reboot root -l /init.sh" /etc/crontab
fi
### switch off mitigations improving linux performance
sudo sed -i '/GRUB_CMDLINE_LINUX_DEFAULT/c\GRUB_CMDLINE_LINUX_DEFAULT="quiet splash udev.log_priority=3 audit=0 noibrs noibpb nopti nospectre_v2 nospectre_v1 l1tf=off nospec_store_bypass_disable no_stf_barrier pti=off mds=off spectre_v1=off spectre_v2_user=off spec_store_bypass_disable=off mitigations=off scsi_mod.use_blk_mq=1 idle=poll tsx_async_abort=off elevator=none i915.enable_rc6=0 acpi_osi=Linux"' /etc/default/grub
sudo sed -i '/GRUB_CMDLINE_LINUX/c\GRUB_CMDLINE_LINUX="quiet splash udev.log_priority=3 audit=0 noibrs noibpb nopti nospectre_v2 nospectre_v1 l1tf=off nospec_store_bypass_disable no_stf_barrier pti=off mds=off spectre_v1=off spectre_v2_user=off spec_store_bypass_disable=off mitigations=off scsi_mod.use_blk_mq=1 idle=poll tsx_async_abort=off elevator=none i915.enable_rc6=0 acpi_osi=Linux"' /etc/default/grub
### apply grub settings
sudo update-grub2
### grub auto detection
GRUB_PATH=$(sudo fdisk -l | grep '^/dev/[a-z]*[0-9]' | awk '$2 == "*"' | cut -d" " -f1 | cut -c1-8)
sudo grub-install $GRUB_PATH
