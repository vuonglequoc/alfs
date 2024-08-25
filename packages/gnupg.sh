#!/bin/bash

KPKG_SRC_FILE=gnupg-2.5.0.tar.bz2
KPKG_SRC_FOLDER=gnupg-2.5.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  ../configure --prefix=/usr          \
              --localstatedir=/var    \
              --sysconfdir=/etc       \
              --docdir=/usr/share/doc/gnupg-2.5.0
}

k_build() {
  make
  makeinfo --html --no-split -I doc -o doc/gnupg_nochunks.html ../doc/gnupg.texi
  makeinfo --plaintext       -I doc -o doc/gnupg.txt           ../doc/gnupg.texi
  make -C doc html
}

k_install() {
  make install

  install -v -m755 -d /usr/share/doc/gnupg-2.5.0/html
  install -v -m644    doc/gnupg_nochunks.html \
                      /usr/share/doc/gnupg-2.5.0/html/gnupg.html
  install -v -m644    ../doc/*.texi doc/gnupg.txt \
                      /usr/share/doc/gnupg-2.5.0
  install -v -m644    doc/gnupg.html/* \
                      /usr/share/doc/gnupg-2.5.0/html
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -v -m755 -d $KPKG_TMP_DIR/usr/share/doc/gnupg-2.5.0/html
  install -v -m644    doc/gnupg_nochunks.html \
                      $KPKG_TMP_DIR/usr/share/doc/gnupg-2.5.0/html/gnupg.html
  install -v -m644    ../doc/*.texi doc/gnupg.txt \
                      $KPKG_TMP_DIR/usr/share/doc/gnupg-2.5.0
  install -v -m644    doc/gnupg.html/* \
                      $KPKG_TMP_DIR/usr/share/doc/gnupg-2.5.0/html
}
