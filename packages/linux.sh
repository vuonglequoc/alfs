#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=linux-6.7.4.tar.xz
SRC_FOLDER=linux-6.7.4

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

make mrproper

# generate config close to current running system
# make defconfig
cp /alfs/defaults/config-6.7.4.base.uefi .config
# make menuconfig

make
make modules_install

cp -iv arch/x86_64/boot/bzImage /boot/vmlinuz-6.7.4-lfs-12.1

cp -iv System.map /boot/System.map-6.7.4

cp -iv .config /boot/config-6.7.4

cp -r Documentation -T /usr/share/doc/linux-6.7.4

# 10.3.2. Configuring Linux Module Load Order

install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
