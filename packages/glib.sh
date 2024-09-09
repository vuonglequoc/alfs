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
  # glib without gobject-introspection
  DESTDIR=$KPKG_TMP_DIR ninja install

  # gobject-introspection
  tar xf ../../gobject-introspection-1.81.2.tar.xz
  meson setup gobject-introspection-1.81.2 gi-build \
              --prefix=/usr --buildtype=release
  ninja -C gi-build
  # ninja -C gi-build test
  DESTDIR=$KPKG_TMP_DIR ninja -C gi-build install

  # glib with gobject-introspection
  meson configure -Dintrospection=enabled
  ninja
  DESTDIR=$KPKG_TMP_DIR ninja install
}

k_post_install() {
  # as a non-root user
  # LC_ALL=C ninja test
  :
}
