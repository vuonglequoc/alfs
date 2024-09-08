#!/bin/bash

KPKG_SRC_FILE=libgcrypt-1.11.0.tar.bz2
KPKG_SRC_FOLDER=libgcrypt-1.11.0

k_configure() {
  ./configure --prefix=/usr
}

k_build() {
  make
  make -C doc html
  makeinfo --html --no-split -o doc/gcrypt_nochunks.html doc/gcrypt.texi
  makeinfo --plaintext       -o doc/gcrypt.txt           doc/gcrypt.texi
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -v -dm755   $KPKG_TMP_DIR/usr/share/doc/libgcrypt-1.11.0
  install -v -m644    README doc/{README.apichanges,fips*,libgcrypt*} \
                      $KPKG_TMP_DIR/usr/share/doc/libgcrypt-1.11.0

  install -v -dm755   $KPKG_TMP_DIR/usr/share/doc/libgcrypt-1.11.0/html
  install -v -m644 doc/gcrypt.html/* \
                      $KPKG_TMP_DIR/usr/share/doc/libgcrypt-1.11.0/html
  install -v -m644 doc/gcrypt_nochunks.html \
                      $KPKG_TMP_DIR/usr/share/doc/libgcrypt-1.11.0
  install -v -m644 doc/gcrypt.{txt,texi} \
                      $KPKG_TMP_DIR/usr/share/doc/libgcrypt-1.11.0
}
