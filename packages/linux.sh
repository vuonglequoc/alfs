#!/bin/bash

KPKG_SRC_FILE=linux-6.10.7.tar.xz
KPKG_SRC_FOLDER=linux-6.10.7

k_pre_configure() {
  make mrproper
}

k_configure() {
  # generate config close to current running system
  # make defconfig
  cp /alfs/defaults/boot/config-6.10.7.base.uefi .config
  # make menuconfig
}

k_check() {
  :
}

k_pre_install() {
make DESTDIR=$KPKG_TMP_DIR modules_install

mkdir -pv $KPKG_TMP_DIR/boot
cp -v arch/x86_64/boot/bzImage $KPKG_TMP_DIR/boot/vmlinuz-6.10.7-lfs-12.2
cp -v System.map $KPKG_TMP_DIR/boot/System.map-6.10.7-lfs-12.2
cp -v .config $KPKG_TMP_DIR/boot/config-6.10.7-lfs-12.2

mkdir -pv $KPKG_TMP_DIR/usr/share/doc
cp -r Documentation -T $KPKG_TMP_DIR/usr/share/doc/linux-6.10.7

# 10.3.2. Configuring Linux Module Load Order
install -v -m755 -d $KPKG_TMP_DIR/etc/modprobe.d
cat > $KPKG_TMP_DIR/etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF
}
