#!/bin/bash

KPKG_SRC_FILE=libfm-1.3.2.tar.xz
KPKG_SRC_FOLDER=libfm-1.3.2

k_configure() {
  ./configure --prefix=/usr     \
              --sysconfdir=/etc \
              --with-extra-only \
              --with-gtk=no     \
              --disable-static
}

k_check() {
  :
}

k_post_install() {
  /sbin/ldconfig
}
