#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
  echo "Script must be run as user: lfs"
  echo "sudo su lfs"
  exit 255
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

source $ALFS/kpkg/kpkg.sh

# Chapter 5. Compiling a Cross-Toolchain
kpkg_installtool cross-toolchain/binutils-pass-1
kpkg_installtool cross-toolchain/gcc-pass-1
kpkg_installtool cross-toolchain/linux-api-headers
kpkg_installtool cross-toolchain/glibc
kpkg_installtool cross-toolchain/libstdc-pass-1

echo
echo "Done"
echo
