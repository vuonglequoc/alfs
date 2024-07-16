#!/bin/bash

KPKG_SRC_FILE=Python-3.12.2.tar.xz
KPKG_SRC_FOLDER=Python-3.12.2

k_configure() {
  ./configure --prefix=/usr   \
              --enable-shared \
              --without-ensurepip
}

k_check() {
  :
}
