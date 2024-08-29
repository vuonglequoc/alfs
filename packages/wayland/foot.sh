#!/bin/bash

KPKG_SRC_FILE=foot-1.18.0.tar.gz
KPKG_SRC_FOLDER=foot-1.18.0

k_pre_configure() {
  mkdir build
  cd    build

  export CFLAGS="$CFLAGS -O3"
}

k_configure() {
  meson setup .. \
        --prefix=/usr \
        --buildtype=release \
        -Dcustom-terminfo-install-location=lib/foot/terminfo \
        -Db_lto=true \
        -Ddocs=disabled
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
  mkdir -p /home/$NONROOT_USER/.config/foot/
  cp -r /alfs/defaults/.config/foot/* /home/$NONROOT_USER/.config/foot/
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install

  mkdir -p $KPKG_TMP_DIR/home/$NONROOT_USER/.config/foot/
  cp -r /alfs/defaults/.config/foot/* $KPKG_TMP_DIR/home/$NONROOT_USER/.config/foot/
}
