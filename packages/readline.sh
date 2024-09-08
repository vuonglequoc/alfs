#!/bin/bash

KPKG_SRC_FILE=readline-8.2.tar.gz
KPKG_SRC_FOLDER=readline-8.2

k_pre_configure() {
  sed -i '/MV.*old/d' Makefile.in
  sed -i '/{OLDSUFF}/c:' support/shlib-install

  patch -Np1 -i ../readline-8.2-upstream_fixes-3.patch
}

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --with-curses    \
              --docdir=/usr/share/doc/readline-8.2
}

k_build() {
  make SHLIB_LIBS="-lncursesw"
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR SHLIB_LIBS="-lncursesw" install

  install -v -m644 doc/*.{ps,pdf,html,dvi} $KPKG_TMP_DIR/usr/share/doc/readline-8.2
}
