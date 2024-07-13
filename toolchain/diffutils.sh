#!/bin/bash

SRC_FILE=diffutils-3.10.tar.xz
SRC_FOLDER=diffutils-3.10

k_configure() {
  ./configure --prefix=/usr   \
              --host=$LFS_TGT \
              --build=$(./build-aux/config.guess)
}

k_check() {
  :
}

k_install() {
  make DESTDIR=$LFS install
}
