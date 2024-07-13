#!/bin/bash

SRC_FILE=findutils-4.9.0.tar.xz
SRC_FOLDER=findutils-4.9.0

k_configure() {
  ./configure --prefix=/usr                   \
              --localstatedir=/var/lib/locate \
              --host=$LFS_TGT                 \
              --build=$(build-aux/config.guess)
}

k_check() {
  :
}

k_install() {
  make DESTDIR=$LFS install
}
