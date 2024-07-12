#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
  echo "Script must be run as user: lfs"
  echo "su lfs -"
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

source $ALFS/scripts/kbuild.sh

# Chapter 6. Cross Compiling Temporary Tools

# 6.2. M4-1.4.19
kbuild $ALFS toolchain m4

# 6.3. Ncurses-6.4-20230520
kbuild $ALFS toolchain ncurses

# 6.4. Bash-5.2.21
kbuild $ALFS toolchain bash

# 6.5. Coreutils-9.4
kbuild $ALFS toolchain coreutils

# 6.6. Diffutils-3.10
kbuild $ALFS toolchain diffutils

# 6.7. File-5.45
kbuild $ALFS toolchain file

# 6.8. Findutils-4.9.0
kbuild $ALFS toolchain findutils

# 6.9. Gawk-5.3.0
kbuild $ALFS toolchain gawk

# 6.10. Grep-3.11
kbuild $ALFS toolchain grep

# 6.11. Gzip-1.13
kbuild $ALFS toolchain gzip

# 6.12. Make-4.4.1
kbuild $ALFS toolchain make

# 6.13. Patch-2.7.6
kbuild $ALFS toolchain patch

# 6.14. Sed-4.9
kbuild $ALFS toolchain sed

# 6.15. Tar-1.35
kbuild $ALFS toolchain tar

# 6.16. Xz-5.4.6
kbuild $ALFS toolchain xz

# 6.17. Binutils-2.42 - Pass 2
kbuild $ALFS toolchain binutils-pass-2

# 6.18. GCC-13.2.0 - Pass 2
kbuild $ALFS toolchain gcc-pass-2

echo
echo "Temp Toolchain completed."
echo
