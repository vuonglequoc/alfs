#!/bin/bash

KPKG_SRC_FILE=libXdamage-1.1.6.tar.xz
KPKG_SRC_FOLDER=libXdamage-1.1.6
XORG_PREFIX=/usr
XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc \
    --localstatedir=/var --disable-static"
DOCDIR="--docdir=$XORG_PREFIX/share/doc/$KPKG_SRC_FOLDER"

k_configure() {
  ./configure $XORG_CONFIG $DOCDIR
}

k_post_install() {
  /sbin/ldconfig
}
