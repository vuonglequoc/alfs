#!/bin/bash

KPKG_SRC_FILE=bzip2-1.0.8.tar.gz
KPKG_SRC_FOLDER=bzip2-1.0.8

k_pre_configure() {
  patch -Np1 -i ../bzip2-1.0.8-install_docs-1.patch
  sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
  sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile
  make -f Makefile-libbz2_so
  make clean
}

k_configure() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR PREFIX=/usr install

  mkdir -pv $KPKG_TMP_DIR/usr/lib
  cp -av libbz2.so.* $KPKG_TMP_DIR/usr/lib
  ln -sv libbz2.so.1.0.8 $KPKG_TMP_DIR/usr/lib/libbz2.so

  mkdir -pv $KPKG_TMP_DIR/usr/bin
  cp -v bzip2-shared $KPKG_TMP_DIR/usr/bin/bzip2
  for i in $KPKG_TMP_DIR/usr/bin/{bzcat,bunzip2}; do
    ln -sfv bzip2 $i
  done

  rm -fv $KPKG_TMP_DIR/usr/lib/libbz2.a
}
