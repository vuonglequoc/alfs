#!/bin/bash

KPKG_SRC_FILE=gawk-5.3.0.tar.xz
KPKG_SRC_FOLDER=gawk-5.3.0

k_pre_configure() {
  sed -i 's/extras//' Makefile.in
}

k_configure() {
  ./configure --prefix=/usr   \
              --host=$LFS_TGT \
              --build=$(build-aux/config.guess)
}

k_check() {
  :
}

k_install() {
  make DESTDIR=$LFS install
}
