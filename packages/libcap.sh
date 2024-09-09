#!/bin/bash

KPKG_SRC_FILE=libcap-2.70.tar.xz
KPKG_SRC_FOLDER=libcap-2.70

k_pre_configure() {
  sed -i '/install -m.*STA/d' libcap/Makefile
}

k_configure() {
  :
}

k_build() {
  make prefix=/usr lib=lib
}

k_check() {
  make test
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR prefix=/usr lib=lib install
}
