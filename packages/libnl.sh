#!/bin/bash

KPKG_SRC_FILE=libnl-3.10.0.tar.gz
KPKG_SRC_FOLDER=libnl-3.10.0

k_configure() {
  ./configure --prefix=/usr     \
              --sysconfdir=/etc \
              --disable-static
}

k_post_install() {
  mkdir -vp /usr/share/doc/libnl-3.10.0
  tar -xf ../libnl-doc-3.10.0.tar.gz --strip-components=1 --no-same-owner \
      -C  /usr/share/doc/libnl-3.10.0
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR install

  mkdir -vp $KPKG_TMP_DIR/usr/share/doc/libnl-3.10.0
  tar -xf ../libnl-doc-3.10.0.tar.gz --strip-components=1 --no-same-owner \
      -C  $KPKG_TMP_DIR/usr/share/doc/libnl-3.10.0
}
