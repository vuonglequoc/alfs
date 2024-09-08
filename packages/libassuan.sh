#!/bin/bash

KPKG_SRC_FILE=libassuan-3.0.1.tar.bz2
KPKG_SRC_FOLDER=libassuan-3.0.1

k_configure() {
  ./configure --prefix=/usr
}

k_build() {
  make
  make -C doc html
  makeinfo --html --no-split -o doc/assuan_nochunks.html doc/assuan.texi
  makeinfo --plaintext       -o doc/assuan.txt           doc/assuan.texi
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -v -dm755   $KPKG_TMP_DIR/usr/share/doc/libassuan-3.0.1/html
  install -v -m644 doc/assuan.html/* \
                      $KPKG_TMP_DIR/usr/share/doc/libassuan-3.0.1/html
  install -v -m644 doc/assuan_nochunks.html \
                      $KPKG_TMP_DIR/usr/share/doc/libassuan-3.0.1
  install -v -m644 doc/assuan.{txt,texi} \
                      $KPKG_TMP_DIR/usr/share/doc/libassuan-3.0.1
}
