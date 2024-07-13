#!/bin/bash

SRC_FILE=m4-1.4.19.tar.xz
SRC_FOLDER=m4-1.4.19

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
