#!/bin/bash

KPKG_SRC_FILE=x264-20240812.tar.xz
KPKG_SRC_FOLDER=x264-20240812

k_configure() {
  ./configure --prefix=/usr   \
              --enable-shared \
              --disable-cli
}

k_check() {
  :
}
