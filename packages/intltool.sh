#!/bin/bash

KPKG_SRC_FILE=intltool-0.51.0.tar.gz
KPKG_SRC_FOLDER=intltool-0.51.0

k_pre_configure() {
  sed -i 's:\\\${:\\\$\\{:' intltool-update.in
}

k_configure() {
  ./configure --prefix=/usr
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -v -Dm644 doc/I18N-HOWTO $KPKG_TMP_DIR/usr/share/doc/intltool-0.51.0/I18N-HOWTO
}
