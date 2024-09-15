#!/bin/bash

# initramfs # Already built in build_post_lfs step
# dosfstools-4.2
# smartmontools-7.4

source /alfs/kpkg/kpkg.sh

kpkg_install dosfstools
# No need update Linux Kernel for FAT because already config for GRUB UEFI

# Update Linux Kernel for exFAT, NTFS support
cd /sources/linux-6.10.7
cp /alfs/defaults/boot/config-6.10.7.base.uefi.iptables.ntfs .config
make
make modules_install
cp -v arch/x86_64/boot/bzImage /boot/vmlinuz-$(uname -r)-lfs-12.2
cp -v System.map /boot/System.map-$(uname -r)-lfs-12.2
cp -v .config /boot/config-$(uname -r)-lfs-12.2

# ensure the mount command uses NTFS3 for ntfs partitions
cat > /usr/sbin/mount.ntfs << "EOF" &&
#!/bin/sh
exec mount -t ntfs3 "$@"
EOF
chmod -v 755 /usr/sbin/mount.ntfs

kpkg_install smartmontools
