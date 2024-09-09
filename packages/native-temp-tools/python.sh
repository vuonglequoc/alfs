#!/bin/bash

KPKG_SRC_FILE=Python-3.12.5.tar.xz
KPKG_SRC_FOLDER=Python-3.12.5

k_configure() {
  ./configure --prefix=/usr   \
              --enable-shared \
              --without-ensurepip
}

k_check() {
  :
}
