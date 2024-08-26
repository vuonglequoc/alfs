#!/bin/bash

KPKG_SRC_FILE=shared-mime-info-2.4.tar.gz
KPKG_SRC_FOLDER=shared-mime-info-2.4

k_pre_configure() {
  tar -xf ../xdgmime.tar.xz
  make -C xdgmime

  mkdir build
  cd    build
}

k_configure() {
  meson setup --prefix=/usr --buildtype=release -D update-mimedb=true ..
}

k_build() {
  ninja
}

k_check() {
  ninja test
}

k_install() {
  ninja install
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
