#!/bin/bash

KPKG_SRC_FILE=libXau-1.0.11.tar.xz
KPKG_SRC_FOLDER=libXau-1.0.11
XORG_PREFIX=/usr
XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc \
    --localstatedir=/var --disable-static"

k_configure() {
  ./configure $XORG_CONFIG
}

k_post_install() {
  /sbin/ldconfig
}
