#!/bin/bash

KPKG_SRC_FILE=mako-1.9.0.tar.gz
KPKG_SRC_FOLDER=mako-1.9.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup --prefix=/usr --buildtype=release -Dman-pages=disabled ..
}

k_build() {
  ninja
}

k_check() {
  ninja test
  # notify-send -u low|normal|critical "Testing ..."
}

k_install() {
  ninja install
}

k_post_install() {
  mkdir -p /home/user/.config/mako/
  cp -r /alfs/defaults/.config/mako/* /home/user/.config/mako/
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
