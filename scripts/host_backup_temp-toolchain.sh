#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ -z ${LFS} ]
  then echo "LFS is not defined. example; export LFS=/mnt/lfs"
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

# 7.13.2. Backup
echo "Backing up.."
cd $LFS
tar -cJpf $HOME/lfs-temp-tools-12.1.tar.xz .

# 7.13.3. Restore
# cd $LFS
# rm -rf ./*
# tar -xpf $HOME/lfs-temp-tools-12.1.tar.xz
