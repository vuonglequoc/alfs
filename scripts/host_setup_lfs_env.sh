#!/bin/bash

# Chapter 4. Final Preparations

# new lfs user pwd set to lfs

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if mount | grep /mnt/lfs > /dev/null; then
  echo
  echo "LFS mount found."
  echo
else
  echo
  echo "No LFS partition found at /mnt/lfs."
  echo
  echo "Check out README.md"
  echo
  # exit
fi

MAKEFLAGS=-j$(nproc)

# Create the required directory layout
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

# Create LFS folders for cross-compiler
mkdir -pv $LFS/tools

# Set permissions
# chmod -v a+wt $LFS/sources

# Adding the LFS User
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs

echo
echo "Please set the lfs user password"
echo

# passwd lfs
echo 'lfs:lfs' | sudo chpasswd

# Grant lfs full access to all the directories under $LFS by making lfs the owner
chown -Rv lfs $LFS/{usr,lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -Rv lfs $LFS/lib64 ;;
esac

# Grant lfs full access to other directories
chown -Rv lfs $LFS/sources
chown -Rv lfs $LFS/alfs

# 4.4. Setting Up the Environment

cat > /home/lfs/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > /home/lfs/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
ALFS=/mnt/lfs/alfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
MAKEFLAGS=-j$(nproc)
export LFS ALFS LC_ALL LFS_TGT PATH CONFIG_SITE MAKEFLAGS
EOF

chown lfs:lfs /home/lfs/.bash_profile
chown lfs:lfs /home/lfs/.bashrc

echo
echo "Done"
echo
