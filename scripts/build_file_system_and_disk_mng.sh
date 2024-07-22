#!/bin/bash

# initramfs # Already built in build_post_lfs step
# dosfstools-4.2
# smartmontools-7.4

source /alfs/kpkg/kpkg.sh

kpkg_install /alfs packages dosfstools
# No need update Linux Kernel for FAT because already config for GRUB UEFI

# Update Linux Kernel for exFAT, NTFS support
cd /sources/linux-6.7.4
cp /alfs/defaults/config-6.7.4.base.uefi.iptables.ntfs .config
make
make modules_install
cp -v arch/x86_64/boot/bzImage /boot/vmlinuz-6.7.4-lfs-12.1
cp -v System.map /boot/System.map-6.7.4
cp -v .config /boot/config-6.7.4

# ensure the mount command uses NTFS3 for ntfs partitions
cat > /usr/sbin/mount.ntfs << "EOF" &&
#!/bin/sh
exec mount -t ntfs3 "$@"
EOF
chmod -v 755 /usr/sbin/mount.ntfs

kpkg_install /alfs packages smartmontools
