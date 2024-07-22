#!/bin/bash

KPKG_SRC_FILE=zip30.tar.gz
KPKG_SRC_FOLDER=zip30

k_configure() {
  :
}

k_build() {
  make -f unix/Makefile generic_gcc
}

k_check() {
  :
}

k_install() {
  make prefix=/usr MANDIR=/usr/share/man/man1 -f unix/Makefile install
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR prefix=/usr MANDIR=/usr/share/man/man1 -f unix/Makefile install
}
