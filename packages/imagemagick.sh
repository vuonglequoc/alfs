#!/bin/bash

KPKG_SRC_FILE=ImageMagick-7.1.1-35.tar.xz
KPKG_SRC_FOLDER=ImageMagick-7.1.1-35

k_configure() {
  ./configure --prefix=/usr     \
              --sysconfdir=/etc \
              --enable-hdri     \
              --with-modules    \
              --with-perl       \
              --disable-static
}

k_install() {
  make DOCUMENTATION_PATH=/usr/share/doc/imagemagick-7.1.1 install
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR DOCUMENTATION_PATH=/usr/share/doc/imagemagick-7.1.1 install
}
