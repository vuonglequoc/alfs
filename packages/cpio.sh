#!/bin/bash

KPKG_SRC_FILE=cpio-2.15.tar.bz2
KPKG_SRC_FOLDER=cpio-2.15

k_configure() {
  ./configure --prefix=/usr \
              --enable-mt   \
              --with-rmt=/usr/libexec/rmt
}

k_build() {
  make
  makeinfo --html            -o doc/html      doc/cpio.texi
  makeinfo --html --no-split -o doc/cpio.html doc/cpio.texi
  makeinfo --plaintext       -o doc/cpio.txt  doc/cpio.texi
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -v -m755 -d $KPKG_TMP_DIR/usr/share/doc/cpio-2.15/html
  install -v -m644    doc/html/* \
                      $KPKG_TMP_DIR/usr/share/doc/cpio-2.15/html
  install -v -m644    doc/cpio.{html,txt} \
                      $KPKG_TMP_DIR/usr/share/doc/cpio-2.15
}
