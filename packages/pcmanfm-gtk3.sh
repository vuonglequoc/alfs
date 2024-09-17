#!/bin/bash

KPKG_SRC_FILE=pcmanfm-1.3.2.tar.xz
KPKG_SRC_FOLDER=pcmanfm-1.3.2

k_pre_configure() {
  patch -Np1 -i /alfs/patches/pcmanfm-gtk3-1.3.2_gcc14_fixes-1.patch
}

k_configure() {
  ./configure --prefix=/usr \
      --sysconfdir=/etc \
      --with-gtk=3
}

k_check() {
  :
}
