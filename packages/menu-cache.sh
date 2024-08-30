#!/bin/bash

KPKG_SRC_FILE=menu-cache-1.1.0.tar.xz
KPKG_SRC_FOLDER=menu-cache-1.1.0

k_pre_configure() {
  patch -Np1 -i ../menu-cache-1.1.0-consolidated_fixes-1.patch
}

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static
}

k_check() {
  :
}

k_post_install() {
  /sbin/ldconfig
}
