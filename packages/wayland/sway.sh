#!/bin/bash

KPKG_SRC_FILE=sway-1.9.tar.gz
KPKG_SRC_FOLDER=sway-1.9

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..            \
        --prefix=/usr       \
        --buildtype=release \
        -Dman-pages=disabled
}

k_build() {
  ninja
}

k_check() {
  ninja test
}

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install
  cp /alfs/defaults/usr/bin/startw $KPKG_TMP_DIR/usr/bin/startw
}

k_post_install() {
  mkdir -p /home/$NONROOT_USER/.config/sway/
  cp -r /alfs/defaults/.config/sway/* /home/$NONROOT_USER/.config/sway/

  cp /alfs/defaults/bash_profile /home/$NONROOT_USER/.bash_profile
  echo "export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib" >> /home/$NONROOT_USER/.bashrc

  usermod -aG input $NONROOT_USER
  usermod -aG audio $NONROOT_USER
  usermod -aG video $NONROOT_USER
}
