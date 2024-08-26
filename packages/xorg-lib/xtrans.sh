#!/bin/bash

KPKG_SRC_FILE=xtrans-1.5.0.tar.xz
KPKG_SRC_FOLDER=xtrans-1.5.0
XORG_PREFIX=/usr
XORG_CONFIG2="--prefix=$XORG_PREFIX --sysconfdir=/etc \
    --localstatedir=/var"
DOCDIR="--docdir=$XORG_PREFIX/share/doc/$KPKG_SRC_FOLDER"

k_configure() {
  ./configure $XORG_CONFIG2 $DOCDIR
}

k_post_install() {
  /sbin/ldconfig
}
