#!/bin/bash

SRC_FILE=make-4.4.1.tar.gz
SRC_FOLDER=make-4.4.1

k_configure() {
  ./configure --prefix=/usr   \
              --without-guile \
              --host=$LFS_TGT \
              --build=$(build-aux/config.guess)
}

k_check() {
  :
}

k_install() {
  make DESTDIR=$LFS install
}
