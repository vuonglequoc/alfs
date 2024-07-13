#!/bin/bash

SRC_FILE=inetutils-2.5.tar.xz
SRC_FOLDER=inetutils-2.5

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

k_post_install() {
  mv -v /usr/{,s}bin/ifconfig
}
