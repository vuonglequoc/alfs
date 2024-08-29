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
        -D gtk_doc=false    \
        -D man=false
}

k_build() {
  ninja
}

k_check() {
  :
}

k_install() {
  ninja install
}

k_post_install() {
  if [ -e /usr/share/doc/libnotify ]; then
    rm -rf /usr/share/doc/libnotify-0.8.3
    mv -v  /usr/share/doc/libnotify{,-0.8.3}
  fi
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install

  if [ -e $KPKG_TMP_DIR/usr/share/doc/libnotify ]; then
    rm -rf $KPKG_TMP_DIR/usr/share/doc/libnotify-0.8.3
    mv -v  $KPKG_TMP_DIR/usr/share/doc/libnotify{,-0.8.3}
  fi
}
