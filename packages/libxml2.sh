#!/bin/bash

KPKG_SRC_FILE=libxml2-2.13.2.tar.xz
KPKG_SRC_FOLDER=libxml2-2.13.2

k_configure() {
  ./configure --prefix=/usr           \
              --sysconfdir=/etc       \
              --disable-static        \
              --with-history          \
              --with-icu              \
              PYTHON=/usr/bin/python3 \
              --docdir=/usr/share/doc/libxml2-2.13.2
}

k_check() {
  tar xf ../xmlts20130923.tar.gz
  make check > check.log
  grep -E '^Total|expected|Ran' check.log
}

k_post_install() {
  rm -vf /usr/lib/libxml2.la
  sed '/libs=/s/xml2.*/xml2"/' -i /usr/bin/xml2-config
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR install

  rm -vf $KPKG_TMP_DIR/usr/lib/libxml2.la
}
