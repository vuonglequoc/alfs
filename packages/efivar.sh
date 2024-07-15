#!/bin/bash

SRC_FILE=efivar-39.tar.gz
SRC_FOLDER=efivar-39

k_configure() {
  :
}

k_check() {
  :
}

k_install() {
  make install LIBDIR=/usr/lib
}

k_pre_record() {
  make DESTDIR=$KPKG_DEST_DIR install LIBDIR=/usr/lib
}
