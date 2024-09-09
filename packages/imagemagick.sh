#!/bin/bash

KPKG_SRC_FILE=ImageMagick-7.1.1-36.tar.xz
KPKG_SRC_FOLDER=ImageMagick-7.1.1-36

k_configure() {
  ./configure --prefix=/usr     \
              --sysconfdir=/etc \
              --enable-hdri     \
              --with-modules    \
              --with-perl       \
              --disable-static
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR DOCUMENTATION_PATH=/usr/share/doc/imagemagick-7.1.1 install
}
