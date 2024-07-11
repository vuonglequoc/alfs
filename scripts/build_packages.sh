#!/bin/bash

source /alfs/scripts/logging.sh

# 8.3. Man-pages-6.06
logging /alfs packages man-pages
logging /alfs packages iana-etc
logging /alfs packages glibc
logging /alfs packages zlib
logging /alfs packages bzip2
logging /alfs packages xz
logging /alfs packages zstd
logging /alfs packages file
logging /alfs packages readline
logging /alfs packages m4
logging /alfs packages bc
logging /alfs packages flex
logging /alfs packages tcl
logging /alfs packages expect
logging /alfs packages dejagnu
logging /alfs packages pkgconf
logging /alfs packages binutils
logging /alfs packages gmp
logging /alfs packages mpfr
logging /alfs packages mpc
logging /alfs packages attr
logging /alfs packages acl
logging /alfs packages libcap
logging /alfs packages libxcrypt
logging /alfs packages shadow
logging /alfs packages gcc
logging /alfs packages ncurses
logging /alfs packages sed
logging /alfs packages psmisc
logging /alfs packages gettext
logging /alfs packages bison
logging /alfs packages grep
logging /alfs packages bash
logging /alfs packages libtool
logging /alfs packages gdbm
logging /alfs packages gpref
logging /alfs packages expat
logging /alfs packages inetutils
logging /alfs packages less
logging /alfs packages perl
logging /alfs packages xml-parser
logging /alfs packages intltool
logging /alfs packages autoconf
logging /alfs packages automake
logging /alfs packages openssl
logging /alfs packages kmod
logging /alfs packages libelf
logging /alfs packages libffi
logging /alfs packages python
logging /alfs packages flit_core
logging /alfs packages wheel
logging /alfs packages setuptools
logging /alfs packages ninja
logging /alfs packages meson
logging /alfs packages coreutils
logging /alfs packages check
logging /alfs packages diffutils
logging /alfs packages gawk
logging /alfs packages findutils
logging /alfs packages groff
logging /alfs packages mandoc
logging /alfs packages efivar
logging /alfs packages popt
logging /alfs packages efibootmgr
logging /alfs packages freetype
logging /alfs packages grub
logging /alfs packages gzip
logging /alfs packages iproute2
logging /alfs packages kbd
logging /alfs packages libpipeline
logging /alfs packages make
logging /alfs packages patch
logging /alfs packages tar
logging /alfs packages texinfo
logging /alfs packages vim
logging /alfs packages markupsafe
logging /alfs packages jinja2
logging /alfs packages udev
logging /alfs packages man-db
logging /alfs packages procps-ng
logging /alfs packages util-linux
logging /alfs packages e2fsprogs
logging /alfs packages sysklogd
logging /alfs packages sysvinit

# 8.83. Stripping
/alfs/scripts/strip.sh

# 8.84. Cleaning Up
echo "Cleaning Up ..."

rm -rf /tmp/*

find /usr/lib /usr/libexec -name \*.la -delete

find /usr -depth -name $(uname -m)-lfs-linux-gnu\* | xargs rm -rf

userdel -r tester

exit
