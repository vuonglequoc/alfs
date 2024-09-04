#!/bin/bash

source /alfs/kpkg/kpkg.sh

# 8.3. Man-pages-6.06
kpkg_install man-pages
kpkg_install iana-etc
kpkg_install glibc
kpkg_install zlib
kpkg_install bzip2
kpkg_install xz
kpkg_install zstd
kpkg_install file
kpkg_install readline
kpkg_install m4
kpkg_install bc
kpkg_install flex
kpkg_install tcl
kpkg_install expect
kpkg_install dejagnu
kpkg_install pkgconf
kpkg_install binutils
kpkg_install gmp
kpkg_install mpfr
kpkg_install mpc
kpkg_install attr
kpkg_install acl
kpkg_install libcap
kpkg_install libxcrypt
kpkg_install shadow
kpkg_install gcc
kpkg_install ncurses
kpkg_install sed
kpkg_install psmisc
kpkg_install gettext
kpkg_install bison
kpkg_install grep
kpkg_install bash
kpkg_install libtool
kpkg_install gdbm
kpkg_install gpref
kpkg_install expat
kpkg_install inetutils
kpkg_install less
kpkg_install perl
kpkg_install xml-parser
kpkg_install intltool
kpkg_install autoconf
kpkg_install automake
kpkg_install openssl
kpkg_install kmod
kpkg_install libelf
kpkg_install libffi
kpkg_install python
kpkg_install python/flit_core
kpkg_install python/wheel
kpkg_install python/setuptools
kpkg_install ninja
kpkg_install python/meson
kpkg_install coreutils
kpkg_install check
kpkg_install diffutils
kpkg_install gawk
kpkg_install findutils
kpkg_install groff
kpkg_install mandoc
kpkg_install efivar
kpkg_install popt
kpkg_install efibootmgr
kpkg_install freetype
kpkg_install grub
kpkg_install gzip
kpkg_install iproute2
kpkg_install kbd
kpkg_install libpipeline
kpkg_install make
kpkg_install patch
kpkg_install tar
kpkg_install texinfo
kpkg_install vim
kpkg_install python/Markupsafe
kpkg_install python/Jinja2
kpkg_install udev
kpkg_install man-db
kpkg_install procps-ng
kpkg_install util-linux
kpkg_install e2fsprogs
kpkg_install sysklogd
kpkg_install sysvinit

# 8.83. Stripping
/alfs/scripts/chroot_strip.sh

# 8.84. Cleaning Up
echo "Cleaning Up ..."

rm -rf /tmp/*

find /usr/lib /usr/libexec -name \*.la -delete

find /usr -depth -name $(uname -m)-lfs-linux-gnu\* | xargs rm -rf

userdel -r tester

exit
