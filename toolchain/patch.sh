#!/bin/bash

SRC_FILE=patch-2.7.6.tar.xz
SRC_FOLDER=patch-2.7.6

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
