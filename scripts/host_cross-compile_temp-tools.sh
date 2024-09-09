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

# Chapter 6. Cross Compiling Temporary Tools
kpkg_installtool cross-temp-tools/m4
kpkg_installtool cross-temp-tools/ncurses
kpkg_installtool cross-temp-tools/bash
kpkg_installtool cross-temp-tools/coreutils
kpkg_installtool cross-temp-tools/diffutils
kpkg_installtool cross-temp-tools/file
kpkg_installtool cross-temp-tools/findutils
kpkg_installtool cross-temp-tools/gawk
kpkg_installtool cross-temp-tools/grep
kpkg_installtool cross-temp-tools/gzip
kpkg_installtool cross-temp-tools/make
kpkg_installtool cross-temp-tools/patch
kpkg_installtool cross-temp-tools/sed
kpkg_installtool cross-temp-tools/tar
kpkg_installtool cross-temp-tools/xz
kpkg_installtool cross-temp-tools/binutils-pass-2
kpkg_installtool cross-temp-tools/gcc-pass-2

echo
echo "Temp Toolchain completed."
echo
