#!/bin/bash

KPKG_SRC_FILE=librsvg-2.58.3.tar.xz
KPKG_SRC_FOLDER=librsvg-2.58.3

k_pre_configure() {
  source /etc/profile
}

k_configure() {
  ./configure --prefix=/usr    \
              --enable-vala    \
              --disable-static \
              --docdir=/usr/share/doc/librsvg-2.58.3
}

k_check() {
  cargo update --precise 0.3.36 time
  LC_ALL=C make check -k
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR DOC_INSTALL_DIR='$(docdir)' install
}
