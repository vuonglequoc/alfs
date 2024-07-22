#!/bin/bash

KPKG_SRC_FILE=unzip60.tar.gz
KPKG_SRC_FOLDER=unzip60

k_pre_configure() {
  patch -Np1 -i ../unzip-6.0-consolidated_fixes-1.patch
}

k_configure() {
  :
}

k_build() {
  make -f unix/Makefile generic
}

k_check() {
  :
}

k_install() {
  make prefix=/usr MANDIR=/usr/share/man/man1 \
    -f unix/Makefile install
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR prefix=/usr MANDIR=/usr/share/man/man1 \
    -f unix/Makefile install
}
