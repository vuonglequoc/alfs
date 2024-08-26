#!/bin/bash

KPKG_SRC_FILE=xcb-proto-1.17.0.tar.xz
KPKG_SRC_FOLDER=xcb-proto-1.17.0
XORG_PREFIX=/usr
XORG_CONFIG2="--prefix=$XORG_PREFIX --sysconfdir=/etc \
    --localstatedir=/var"

k_configure() {
  PYTHON=python3 ./configure $XORG_CONFIG2
}

k_build() {
  :
}

k_post_install() {
  rm -f $XORG_PREFIX/lib/pkgconfig/xcb-proto.pc
}
