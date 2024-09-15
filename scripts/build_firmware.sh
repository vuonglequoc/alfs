#!/bin/bash

# 1. Most firmware
cd /sources
# tar -xf linux-firmware-20240709.tar.gz
# mv linux-firmware-20240709/* /lib/firmware/
# rm -r linux-firmware-20240709
# TODO: check only needed firmware

# 2. Microcode updates for CPUs
head -n7 /proc/cpuinfo
# processor       : 0
# vendor_id       : GenuineIntel
# cpu family      : 6
# model           : 71
# model name      : Intel(R) Core(TM) i5-5575R CPU @ 2.80GHz
# stepping        : 1
# microcode       : 0xffffffff
MICROCODE=06-47-01

# Intel Microcode for the CPU
cd /sources
tar -xf microcode-20240531.tar.gz
# Intel-Linux-Processor-Microcode-Data-Files-microcode-20240531/

# Early loading of microcode
mkdir initrd

## For just use microcode
# mkdir -p initrd/kernel/x86/microcode
# cd initrd
# cp -v /sources/Intel-Linux-Processor-Microcode-Data-Files-microcode-20240531/intel-ucode/$MICROCODE kernel/x86/microcode/GenuineIntel.bin
# find . | cpio -o -H newc > /boot/microcode.img
# echo "Please add a new entry to /boot/grub/grub.cfg"
# echo "  initrd /microcode.img"

## For use mkinitramfs
mkdir /lib/firmware/intel-ucode/
cp -v /sources/Intel-Linux-Processor-Microcode-Data-Files-microcode-20240531/intel-ucode/$MICROCODE /lib/firmware/intel-ucode/

# 3. Firmware for Regulatory Database of Wireless Devices
cd /sources
tar -xf wireless-regdb-2024.07.04.tar.xz
cp -v wireless-regdb-2024.07.04/regulatory.db /lib/firmware/
cp -v wireless-regdb-2024.07.04/regulatory.db.p7s /lib/firmware/
rm -r wireless-regdb-2024.07.04

# 4. Sound Open Firmware
cd /sources
tar -xf sof-bin-2024.03.tar.gz
cd sof-bin-2024.03
install -vdm755 /usr/lib/firmware/intel
cp -av -T --no-preserve=ownership sof \
  /usr/lib/firmware/intel/sof
cp -av -T --no-preserve=ownership sof-tplg \
  /usr/lib/firmware/intel/sof-tplg
cd /sources
rm -r sof-bin-2024.03

cd /sources
tar -xf alsa-ucm-conf-1.2.12.tar.bz2
cd alsa-ucm-conf-1.2.12
install -vdm755 /usr/share/alsa
cp -av -T --no-preserve=ownership ucm2 /usr/share/alsa/ucm2
cd /sources
rm -r alsa-ucm-conf-1.2.12

# 5. Firmware for Other Devices
lspci

echo "search online to check which module it uses, which firmware, and where to obtain the firmware — not all of it is in linux-firmware."

cd /sources/initrd/
mkinitramfs $(uname -r)
mv initrd.img-$(uname -r) /boot/initrd.img-$(uname -r)-lfs-12.2

# add a new entry to /boot/grub/grub.cfg
grub-mkconfig -o /boot/grub/grub.cfg

# reboot
# dmesg | grep -e 'microcode' -e 'Linux version' -e 'Command line'
# [    0.424002] microcode: Microcode Update Driver: v2.2.
