#!/bin/bash

KPKG_SRC_FILE=libxcb-1.17.0.tar.xz
KPKG_SRC_FOLDER=libxcb-1.17.0
XORG_PREFIX=/usr
XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc \
    --localstatedir=/var --disable-static"

k_configure() {
  ./configure $XORG_CONFIG      \
              --without-doxygen \
              --docdir='${datadir}'/doc/libxcb-1.17.0
}

k_build() {
  LC_ALL=en_US.UTF-8 make
}

k_post_install() {
  chown -Rv root:root $XORG_PREFIX/share/doc/libxcb-1.17.0
}
