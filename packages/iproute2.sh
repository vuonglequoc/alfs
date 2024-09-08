#!/bin/bash

KPKG_SRC_FILE=iproute2-6.7.0.tar.xz
KPKG_SRC_FOLDER=iproute2-6.7.0

k_pre_configure() {
  sed -i /ARPD/d Makefile
  rm -fv man/man8/arpd.8
}

k_configure() {
  :
}

k_build() {
  make NETNS_RUN_DIR=/run/netns
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR SBINDIR=/usr/sbin install

  mkdir -pv             $KPKG_TMP_DIR/usr/share/doc/iproute2-6.7.0
  cp -v COPYING README* $KPKG_TMP_DIR/usr/share/doc/iproute2-6.7.0
}
