#!/bin/bash

KPKG_SRC_FILE=util-macros-1.20.1.tar.xz
KPKG_SRC_FOLDER=util-macros-1.20.1
XORG_PREFIX=/usr
XORG_CONFIG2="--prefix=$XORG_PREFIX --sysconfdir=/etc \
    --localstatedir=/var"

k_configure() {
  ./configure $XORG_CONFIG2
}

k_build() {
  :
}

k_check() {
  :
}
