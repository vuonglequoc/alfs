#!/bin/bash

KPKG_SRC_FILE=flex-2.6.4.tar.gz
KPKG_SRC_FOLDER=flex-2.6.4

k_configure() {
  ./configure --prefix=/usr                      \
              --docdir=/usr/share/doc/flex-2.6.4 \
              --disable-static
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  ln -sv flex   $KPKG_TMP_DIR/usr/bin/lex
  ln -sv flex.1 $KPKG_TMP_DIR/usr/share/man/man1/lex.1
}
