#!/bin/bash

KPKG_SRC_FILE=nasm-2.16.03.tar.xz
KPKG_SRC_FOLDER=nasm-2.16.03

k_pre_configure() {
  tar -xf ../nasm-2.16.03-xdoc.tar.xz --strip-components=1
}

k_configure() {
  ./configure --prefix=/usr
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -m755 -d         $KPKG_TMP_DIR/usr/share/doc/nasm-2.16.03/html
  cp -v doc/html/*.html    $KPKG_TMP_DIR/usr/share/doc/nasm-2.16.03/html
  cp -v doc/*.{txt,ps,pdf} $KPKG_TMP_DIR/usr/share/doc/nasm-2.16.03
}
