#!/bin/bash

KPKG_SRC_FILE=inetutils-2.5.tar.xz
KPKG_SRC_FOLDER=inetutils-2.5

k_pre_configure() {
  # make the package build with gcc-14.1 or later
  sed -i 's/def HAVE_TERMCAP_TGETENT/ 1/' telnet/telnet.c
}

k_configure() {
  ./configure --prefix=/usr        \
              --bindir=/usr/bin    \
              --localstatedir=/var \
              --disable-logger     \
              --disable-whois      \
              --disable-rcp        \
              --disable-rexec      \
              --disable-rlogin     \
              --disable-rsh        \
              --disable-servers
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  mkdir -pv $KPKG_TMP_DIR/usr/sbin
  mv -v $KPKG_TMP_DIR/usr/{,s}bin/ifconfig
}
