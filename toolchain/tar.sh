#!/bin/bash

SRC_FILE=tar-1.35.tar.xz
SRC_FOLDER=tar-1.35

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
