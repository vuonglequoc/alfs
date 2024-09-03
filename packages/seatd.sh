#!/bin/bash

KPKG_SRC_FILE=seatd-0.8.0.tar.gz
KPKG_SRC_FOLDER=seatd-0.8.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..             \
        --prefix=/usr        \
        --buildtype=release \
        -Dman-pages=disabled
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

k_post_install() {
  groupadd -r -g 200 seat
  usermod -aG seat $NONROOT_USER

  install -m 754 $KPKG_ROOT/alfs/defaults/init.d/seatd      /etc/rc.d/init.d/
  ln -sf  ../init.d/seatd /etc/rc.d/rc5.d/S40seatd
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install

  mkdir -p $KPKG_TMP_DIR/etc/rc.d/init.d/
  mkdir -p $KPKG_TMP_DIR/etc/rc.d/rc5.d/
  install -m 754 $KPKG_ROOT/alfs/defaults/init.d/seatd      $KPKG_TMP_DIR/etc/rc.d/init.d/
  ln -sf  ../init.d/seatd $KPKG_TMP_DIR/etc/rc.d/rc5.d/S40seatd
}
