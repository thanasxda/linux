#!/bin/bash
sudo sed -i '10s/.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash noibrs noibpb nopti nospectre_v2 nospectre_v1 l1tf=off nospec_store_bypass_disable no_stf_barrier mds=off spectre_v2_user=off spec_store_bypass_disable=off mitigations=off"/' /etc/default/grub
sudo update-grub
clear
echo DONE
