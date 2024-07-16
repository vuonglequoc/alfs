#!/bin/bash

source /alfs/kpkg/kpkg.sh

# 8.3. Man-pages-6.06
kpkg_install /alfs packages man-pages
kpkg_install /alfs packages iana-etc
kpkg_install /alfs packages glibc
kpkg_install /alfs packages zlib
kpkg_install /alfs packages bzip2
kpkg_install /alfs packages xz
kpkg_install /alfs packages zstd
kpkg_install /alfs packages file
kpkg_install /alfs packages readline
kpkg_install /alfs packages m4
kpkg_install /alfs packages bc
kpkg_install /alfs packages flex
kpkg_install /alfs packages tcl
kpkg_install /alfs packages expect
kpkg_install /alfs packages dejagnu
kpkg_install /alfs packages pkgconf
kpkg_install /alfs packages binutils
kpkg_install /alfs packages gmp
kpkg_install /alfs packages mpfr
kpkg_install /alfs packages mpc
kpkg_install /alfs packages attr
kpkg_install /alfs packages acl
kpkg_install /alfs packages libcap
kpkg_install /alfs packages libxcrypt
kpkg_install /alfs packages shadow
kpkg_install /alfs packages gcc
kpkg_install /alfs packages ncurses
kpkg_install /alfs packages sed
kpkg_install /alfs packages psmisc
kpkg_install /alfs packages gettext
kpkg_install /alfs packages bison
kpkg_install /alfs packages grep
kpkg_install /alfs packages bash
kpkg_install /alfs packages libtool
kpkg_install /alfs packages gdbm
kpkg_install /alfs packages gpref
kpkg_install /alfs packages expat
kpkg_install /alfs packages inetutils
kpkg_install /alfs packages less
kpkg_install /alfs packages perl
kpkg_install /alfs packages xml-parser
kpkg_install /alfs packages intltool
kpkg_install /alfs packages autoconf
kpkg_install /alfs packages automake
kpkg_install /alfs packages openssl
kpkg_install /alfs packages kmod
kpkg_install /alfs packages libelf
kpkg_install /alfs packages libffi
kpkg_install /alfs packages python
kpkg_install /alfs packages flit_core
kpkg_install /alfs packages wheel
kpkg_install /alfs packages setuptools
kpkg_install /alfs packages ninja
kpkg_install /alfs packages meson
kpkg_install /alfs packages coreutils
kpkg_install /alfs packages check
kpkg_install /alfs packages diffutils
kpkg_install /alfs packages gawk
kpkg_install /alfs packages findutils
kpkg_install /alfs packages groff
kpkg_install /alfs packages mandoc
kpkg_install /alfs packages efivar
kpkg_install /alfs packages popt
kpkg_install /alfs packages efibootmgr
kpkg_install /alfs packages freetype
kpkg_install /alfs packages grub
kpkg_install /alfs packages gzip
kpkg_install /alfs packages iproute2
kpkg_install /alfs packages kbd
kpkg_install /alfs packages libpipeline
kpkg_install /alfs packages make
kpkg_install /alfs packages patch
kpkg_install /alfs packages tar
kpkg_install /alfs packages texinfo
kpkg_install /alfs packages vim
kpkg_install /alfs packages markupsafe
kpkg_install /alfs packages jinja2
kpkg_install /alfs packages udev
kpkg_install /alfs packages man-db
kpkg_install /alfs packages procps-ng
kpkg_install /alfs packages util-linux
kpkg_install /alfs packages e2fsprogs
kpkg_install /alfs packages sysklogd
kpkg_install /alfs packages sysvinit

# 8.83. Stripping
/alfs/scripts/strip.sh

# 8.84. Cleaning Up
echo "Cleaning Up ..."

rm -rf /tmp/*

find /usr/lib /usr/libexec -name \*.la -delete

find /usr -depth -name $(uname -m)-lfs-linux-gnu\* | xargs rm -rf

userdel -r tester

exit
