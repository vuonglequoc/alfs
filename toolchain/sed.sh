#!/bin/bash

SRC_FILE=sed-4.9.tar.xz
SRC_FOLDER=sed-4.9

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
