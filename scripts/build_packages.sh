#!/bin/bash

source /alfs/scripts/kbuild.sh

# 8.3. Man-pages-6.06
kbuild /alfs packages man-pages
kbuild /alfs packages iana-etc
kbuild /alfs packages glibc
kbuild /alfs packages zlib
kbuild /alfs packages bzip2
kbuild /alfs packages xz
kbuild /alfs packages zstd
kbuild /alfs packages file
kbuild /alfs packages readline
kbuild /alfs packages m4
kbuild /alfs packages bc
kbuild /alfs packages flex
kbuild /alfs packages tcl
kbuild /alfs packages expect
kbuild /alfs packages dejagnu
kbuild /alfs packages pkgconf
kbuild /alfs packages binutils
kbuild /alfs packages gmp
kbuild /alfs packages mpfr
kbuild /alfs packages mpc
kbuild /alfs packages attr
kbuild /alfs packages acl
kbuild /alfs packages libcap
kbuild /alfs packages libxcrypt
kbuild /alfs packages shadow
kbuild /alfs packages gcc
kbuild /alfs packages ncurses
kbuild /alfs packages sed
kbuild /alfs packages psmisc
kbuild /alfs packages gettext
kbuild /alfs packages bison
kbuild /alfs packages grep
kbuild /alfs packages bash
kbuild /alfs packages libtool
kbuild /alfs packages gdbm
kbuild /alfs packages gpref
kbuild /alfs packages expat
kbuild /alfs packages inetutils
kbuild /alfs packages less
kbuild /alfs packages perl
kbuild /alfs packages xml-parser
kbuild /alfs packages intltool
kbuild /alfs packages autoconf
kbuild /alfs packages automake
kbuild /alfs packages openssl
kbuild /alfs packages kmod
kbuild /alfs packages libelf
kbuild /alfs packages libffi
kbuild /alfs packages python
kbuild /alfs packages flit_core
kbuild /alfs packages wheel
kbuild /alfs packages setuptools
kbuild /alfs packages ninja
kbuild /alfs packages meson
kbuild /alfs packages coreutils
kbuild /alfs packages check
kbuild /alfs packages diffutils
kbuild /alfs packages gawk
kbuild /alfs packages findutils
kbuild /alfs packages groff
kbuild /alfs packages mandoc
kbuild /alfs packages efivar
kbuild /alfs packages popt
kbuild /alfs packages efibootmgr
kbuild /alfs packages freetype
kbuild /alfs packages grub
kbuild /alfs packages gzip
kbuild /alfs packages iproute2
kbuild /alfs packages kbd
kbuild /alfs packages libpipeline
kbuild /alfs packages make
kbuild /alfs packages patch
kbuild /alfs packages tar
kbuild /alfs packages texinfo
kbuild /alfs packages vim
kbuild /alfs packages markupsafe
kbuild /alfs packages jinja2
kbuild /alfs packages udev
kbuild /alfs packages man-db
kbuild /alfs packages procps-ng
kbuild /alfs packages util-linux
kbuild /alfs packages e2fsprogs
kbuild /alfs packages sysklogd
kbuild /alfs packages sysvinit

# 8.83. Stripping
/alfs/scripts/strip.sh

# 8.84. Cleaning Up
echo "Cleaning Up ..."

rm -rf /tmp/*

find /usr/lib /usr/libexec -name \*.la -delete

find /usr -depth -name $(uname -m)-lfs-linux-gnu\* | xargs rm -rf

userdel -r tester

exit
