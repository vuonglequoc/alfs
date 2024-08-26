#!/bin/bash

KPKG_SRC_FILE=libcanberra-0.30.tar.xz
KPKG_SRC_FOLDER=libcanberra-0.30

k_pre_configure() {
  patch -Np1 -i ../libcanberra-0.30-wayland-1.patch
}

k_configure() {
  ./configure --prefix=/usr --disable-oss
}

k_check() {
  :
}

k_install() {
  make docdir=/usr/share/doc/libcanberra-0.30 install
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR docdir=/usr/share/doc/libcanberra-0.30 install
}
