#!/bin/bash

KPKG_SRC_FILE=pulseaudio-17.0.tar.xz
KPKG_SRC_FOLDER=pulseaudio-17.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup --prefix=/usr       \
              --buildtype=release \
              -Ddatabase=gdbm     \
              -Ddoxygen=false     \
              -Dbluez5=disabled   \
              ..
}

k_build() {
  ninja
}

k_check() {
  ninja test
}

k_install() {
  ninja install
  rm /usr/share/dbus-1/system.d/pulseaudio-system.conf
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
  rm $KPKG_TMP_DIR/usr/share/dbus-1/system.d/pulseaudio-system.conf
}
