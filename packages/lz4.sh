#!/bin/bash

KPKG_SRC_FILE=lz4-1.10.0.tar.gz
KPKG_SRC_FOLDER=lz4-1.10.0

k_configure() {
  :
}

k_build() {
  make BUILD_STATIC=no PREFIX=/usr
}

k_check() {
  make -j1 check
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR BUILD_STATIC=no PREFIX=/usr install
}
