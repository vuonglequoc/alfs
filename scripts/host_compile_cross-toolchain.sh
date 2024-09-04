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
  exit
fi

source $ALFS/kpkg/kpkg.sh

# Chapter 5. Compiling a Cross-Toolchain

# 5.2. Binutils-2.42 - Pass 1
kpkg_installtool cross-toolchain/binutils-pass-1

# 5.3. GCC-13.2.0 - Pass 1
kpkg_installtool cross-toolchain/gcc-pass-1

# 5.4. Linux-6.10.7 API Headers
kpkg_installtool cross-toolchain/linux-api-headers

# 5.5. Glibc-2.39
kpkg_installtool cross-toolchain/glibc

# 5.6. Libstdc++ from GCC-13.2.0, Pass 1
kpkg_installtool cross-toolchain/libstdc-pass-1

echo
echo "Done"
echo
