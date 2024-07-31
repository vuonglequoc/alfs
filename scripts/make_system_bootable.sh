#!/bin/bash

source /alfs/kpkg/kpkg.sh

# 10.2. Creating the /etc/fstab File
# We can check the UUID of each partition by blkid command
# then update fstab with UUID instead of device name for better mounting
cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point  type     options             dump  fsck
#                                                              order

/dev/sdb3   /                           ext4        defaults                            1   1
#UUID=<XXX> /                           ext4        defaults                            1   1
/dev/sdb2   /boot                       ext4        defaults                            1   1
#UUID=<XXX> /boot                       ext4        defaults                            1   1
/dev/sdb1   /boot/efi                   vfat        codepage=437,iocharset=iso8859-1    0   1
#UUID=<XXX> /boot/efi                   vfat        codepage=437,iocharset=iso8859-1    0   1
/dev/sdb4   swap                        swap        pri=1                               0   0
#UUID=<XXX> swap                        swap        pri=1                               0   0

proc        /proc                       proc        nosuid,noexec,nodev                 0   0
sysfs       /sys                        sysfs       nosuid,noexec,nodev                 0   0
devpts      /dev/pts                    devpts      gid=5,mode=620                      0   0
tmpfs       /run                        tmpfs       defaults                            0   0
devtmpfs    /dev                        devtmpfs    mode=0755,nosuid                    0   0
tmpfs       /dev/shm                    tmpfs       nosuid,nodev                        0   0
cgroup2     /sys/fs/cgroup              cgroup2     nosuid,noexec,nodev                 0   0
efivarfs    /sys/firmware/efi/efivars   efivarfs    defaults                            0   0

# End /etc/fstab
EOF

# Copy bashrc to root
cp /alfs/defaults/bashrc /root/.bashrc

# 10.3. Linux-6.7.4
kpkg_install /alfs packages linux

# 10.4. Using GRUB to Set Up the Boot Process

# 11.1 The End

echo 12.1 > /etc/lfs-release

cat > /etc/lsb-release << "EOF"
DISTRIB_ID="Linux From Scratch"
DISTRIB_RELEASE="12.1"
DISTRIB_CODENAME="Vuong Le"
DISTRIB_DESCRIPTION="Linux From Scratch"
EOF

cat > /etc/os-release << "EOF"
NAME="Linux From Scratch"
VERSION="12.1"
ID=lfs
PRETTY_NAME="Linux From Scratch 12.1"
VERSION_CODENAME="Vuong Le"
HOME_URL="https://github.com/vuonglequoc/"
EOF

echo
echo "Review section.."
echo "10.4. Using GRUB to Set Up the Boot Process"
echo "Not installing grub by default"
echo

exit
