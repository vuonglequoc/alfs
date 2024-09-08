#!/bin/bash

KPKG_SRC_FILE=graphite2-1.3.14.tgz
KPKG_SRC_FOLDER=graphite2-1.3.14

k_pre_configure() {
  sed -i '/cmptest/d' tests/CMakeLists.txt

  mkdir build
  cd    build
}

k_configure() {
  cmake -D CMAKE_INSTALL_PREFIX=/usr ..
}

k_build() {
  make
  make docs
}

k_check() {
  make test
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  # TODO check docs
  install -v -d -m755 $KPKG_TMP_DIR/usr/share/doc/graphite2-1.3.14

  cp      -v -f    doc/{GTF,manual}.html \
                      $KPKG_TMP_DIR/usr/share/doc/graphite2-1.3.14
  cp      -v -f    doc/{GTF,manual}.pdf \
                      $KPKG_TMP_DIR/usr/share/doc/graphite2-1.3.14
}
