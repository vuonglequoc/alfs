#!/bin/bash

KPKG_SRC_FILE=dejagnu-1.6.3.tar.gz
KPKG_SRC_FOLDER=dejagnu-1.6.3

k_pre_configure() {
  mkdir -v build
  cd       build
}

k_configure() {
  ../configure --prefix=/usr
}

k_build() {
  makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi
  makeinfo --plaintext       -o doc/dejagnu.txt  ../doc/dejagnu.texi
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -v -dm755  $KPKG_TMP_DIR/usr/share/doc/dejagnu-1.6.3
  install -v -m644   doc/dejagnu.{html,txt} $KPKG_TMP_DIR/usr/share/doc/dejagnu-1.6.3
}
