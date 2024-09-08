#!/bin/bash

KPKG_SRC_FILE=efivar-39.tar.gz
KPKG_SRC_FOLDER=efivar-39

k_configure() {
  :
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install LIBDIR=/usr/lib
}
