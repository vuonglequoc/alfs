#!/bin/bash

SRC_FILE=kbd-2.6.4.tar.xz
SRC_FOLDER=kbd-2.6.4

k_pre_configure() {
  patch -Np1 -i ../kbd-2.6.4-backspace-1.patch

  sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
  sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
}

k_configure() {
  ./configure --prefix=/usr \
              --disable-vlock
}

k_post_install() {
  cp -R -v docs/doc -T /usr/share/doc/kbd-2.6.4
}
