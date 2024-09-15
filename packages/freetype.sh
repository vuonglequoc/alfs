#!/bin/bash

KPKG_SRC_FILE=freetype-2.13.2.tar.xz
KPKG_SRC_FOLDER=freetype-2.13.2

k_pre_configure() {
  tar -xf ../freetype-doc-2.13.2.tar.xz --strip-components=2 -C docs

  sed -ri "s:.*(AUX_MODULES.*valid):\1:" modules.cfg

  sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" \
      -i include/freetype/config/ftoption.h
}

k_configure() {
  ./configure --prefix=/usr            \
              --enable-freetype-config \
              --disable-static
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  mkdir -pv $KPKG_TMP_DIR/usr/share/doc
  cp -v -R docs -T $KPKG_TMP_DIR/usr/share/doc/freetype-2.13.2
  rm -v $KPKG_TMP_DIR/usr/share/doc/freetype-2.13.2/freetype-config.1
}
