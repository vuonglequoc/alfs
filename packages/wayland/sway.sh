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

k_install() {
  ninja install
}

k_post_install() {
  mkdir -p ~/.config/sway/
  cp -r /alfs/defaults/.config/sway/* ~/.config/sway/
  cp /alfs/defaults/usr/bin/startw /usr/bin/startw
  cp /alfs/defaults/bash_profile ~/.bash_profile

  echo "export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib" >> ~/.bashrc

  usermod -aG input user
  usermod -aG audio user
  usermod -aG video user
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install

  mkdir -p $KPKG_TMP_DIR/home/user/.config/sway/
  cp -r /alfs/defaults/.config/sway/* $KPKG_TMP_DIR/home/user/.config/sway/
  cp /alfs/defaults/usr/bin/startw $KPKG_TMP_DIR/usr/bin/startw
  cp /alfs/defaults/bash_profile $KPKG_TMP_DIR/home/user/.bash_profile

  echo "export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib" >> $KPKG_TMP_DIR/home/user/.bashrc
}
