#!/bin/bash

KPKG_SRC_FILE=gtk+-3.24.43.tar.xz
KPKG_SRC_FOLDER=gtk+-3.24.43

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..                 \
        --prefix=/usr            \
        --buildtype=release      \
        -D man=true              \
        -D broadway_backend=true
}

k_build() {
  ninja
}

k_check() {
  dbus-run-session ninja test
}

k_install() {
  ninja install
}

k_post_install() {
  mkdir -p ~/.config/gtk-3.0/
  cp -r /alfs/defaults/.config/gtk-3.0/* ~/.config/gtk-3.0/
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install

  mkdir -p $KPKG_TMP_DIR/home/user/.config/gtk-3.0/
  cp -r /alfs/defaults/.config/gtk-3.0/* $KPKG_TMP_DIR/home/user/.config/gtk-3.0/
}
