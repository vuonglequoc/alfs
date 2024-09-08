#!/bin/bash

KPKG_SRC_FILE=pango-1.54.0.tar.xz
KPKG_SRC_FOLDER=pango-1.54.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup --prefix=/usr          \
              --buildtype=release    \
              --wrap-mode=nofallback \
              ..
}

k_build() {
  ninja
}

k_check() {
  ninja test
}

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
