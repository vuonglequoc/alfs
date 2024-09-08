#!/bin/bash

KPKG_SRC_FILE=fontconfig-2.15.0.tar.xz
KPKG_SRC_FOLDER=fontconfig-2.15.0

k_configure() {
  ./configure --prefix=/usr        \
              --sysconfdir=/etc    \
              --localstatedir=/var \
              --disable-docs       \
              --docdir=/usr/share/doc/fontconfig-2.15.0
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -v -dm755 \
        $KPKG_TMP_DIR/usr/share/{man/man{1,3,5},doc/fontconfig-2.15.0/fontconfig-devel}
  install -v -m644 fc-*/*.1         $KPKG_TMP_DIR/usr/share/man/man1
  install -v -m644 doc/*.3          $KPKG_TMP_DIR/usr/share/man/man3
  install -v -m644 doc/fonts-conf.5 $KPKG_TMP_DIR/usr/share/man/man5
  install -v -m644 doc/fontconfig-devel/* \
        $KPKG_TMP_DIR/usr/share/doc/fontconfig-2.15.0/fontconfig-devel
  install -v -m644 doc/*.{pdf,sgml,txt,html} \
        $KPKG_TMP_DIR/usr/share/doc/fontconfig-2.15.0
}
