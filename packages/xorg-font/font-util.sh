#!/bin/bash

KPKG_SRC_FILE=font-util-1.4.1.tar.xz
KPKG_SRC_FOLDER=font-util-1.4.1
XORG_PREFIX=/usr
XORG_CONFIG2="--prefix=$XORG_PREFIX --sysconfdir=/etc \
    --localstatedir=/var"

k_configure() {
  ./configure $XORG_CONFIG2
}

k_check() {
  :
}
