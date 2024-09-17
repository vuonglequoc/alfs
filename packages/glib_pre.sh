#!/bin/bash

KPKG_SRC_FILE=glib-2.81.0.tar.xz
KPKG_SRC_FOLDER=glib-2.81.0

k_pre_configure() {
  patch -Np1 -i ../glib-skip_warnings-1.patch

  if [ -e /usr/include/glib-2.0 ]; then
    rm -rf /usr/include/glib-2.0.old
    mv -vf /usr/include/glib-2.0{,.old}
  fi

  mkdir build
  cd    build
}

k_configure() {
  meson setup ..                  \
        --prefix=/usr             \
        --buildtype=release       \
        -D introspection=disabled \
        -D man-pages=enabled
}

k_build() {
  ninja
}

k_check() {
  :
}

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
