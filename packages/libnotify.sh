#!/bin/bash

KPKG_SRC_FILE=libnotify-0.8.3.tar.xz
KPKG_SRC_FOLDER=libnotify-0.8.3

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..             \
        --prefix=/usr        \
        --buildtype=release  \
        -D man=false         \
        -D gtk_doc=false     \
        -D docbook_docs=disabled
}

k_build() {
  ninja
}

k_check() {
  :
}

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install

  if [ -e $KPKG_TMP_DIR/usr/share/doc/libnotify ]; then
    rm -rf $KPKG_TMP_DIR/usr/share/doc/libnotify-0.8.3
    mv -v  $KPKG_TMP_DIR/usr/share/doc/libnotify{,-0.8.3}
  fi
}
