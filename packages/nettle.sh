#!/bin/bash

KPKG_SRC_FILE=nettle-3.10.tar.gz
KPKG_SRC_FOLDER=nettle-3.10

k_configure() {
  ./configure --prefix=/usr --disable-static
}

k_install() {
  make install
  chmod   -v   755 /usr/lib/lib{hogweed,nettle}.so
  install -v -m755 -d /usr/share/doc/nettle-3.10
  install -v -m644 nettle.{html,pdf} /usr/share/doc/nettle-3.10
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR install
  install -v -m755 -d $KPKG_TMP_DIR/usr/share/doc/nettle-3.10
  install -v -m644 nettle.{html,pdf} $KPKG_TMP_DIR/usr/share/doc/nettle-3.10
}
