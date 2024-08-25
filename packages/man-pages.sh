#!/bin/bash

KPKG_SRC_FILE=man-pages-6.06.tar.xz
KPKG_SRC_FOLDER=man-pages-6.06

k_pre_configure() {
  rm -v man3/crypt*
}

k_configure() {
  :
}

k_build() {
  :
}

k_check() {
  :
}

k_install() {
  make prefix=/usr install
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR prefix=/usr install
}
