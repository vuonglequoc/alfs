#!/bin/bash

KPKG_SRC_FILE=ncurses-6.4-20230520.tar.xz
KPKG_SRC_FOLDER=ncurses-6.4-20230520

k_configure() {
  ./configure --prefix=/usr           \
              --mandir=/usr/share/man \
              --with-shared           \
              --without-debug         \
              --without-normal        \
              --with-cxx-shared       \
              --enable-pc-files       \
              --enable-widec          \
              --with-pkg-config-libdir=/usr/lib/pkgconfig
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$PWD/dest install

  mkdir -p $KPKG_TMP_DIR/usr/lib
  install -vm755 dest/usr/lib/libncursesw.so.6.4 $KPKG_TMP_DIR/usr/lib
  rm -v  dest/usr/lib/libncursesw.so.6.4

  sed -e 's/^#if.*XOPEN.*$/#if 1/' \
      -i dest/usr/include/curses.h
  cp -av dest/* $KPKG_TMP_DIR

  for lib in ncurses form panel menu ; do
      ln -sfv lib${lib}w.so $KPKG_TMP_DIR/usr/lib/lib${lib}.so
      ln -sfv ${lib}w.pc    $KPKG_TMP_DIR/usr/lib/pkgconfig/${lib}.pc
  done

  ln -sfv libncursesw.so $KPKG_TMP_DIR/usr/lib/libcurses.so

  cp -v -R doc -T $KPKG_TMP_DIR/usr/share/doc/ncurses-6.4-20230520
}
