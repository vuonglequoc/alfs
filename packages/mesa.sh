#!/bin/bash

KPKG_SRC_FILE=mesa-24.1.5.tar.xz
KPKG_SRC_FOLDER=mesa-24.1.5
export XORG_PREFIX=/usr

k_pre_configure() {
  source /etc/profile

  patch -Np1 -i ../mesa-add_xdemos-2.patch

  mkdir build
  cd    build
}

k_configure() {
  # platforms x11 for GLX for libGL.so for GTK+
  meson setup ..                 \
        --prefix=$XORG_PREFIX    \
        --buildtype=release      \
        -D platforms=x11,wayland \
        -D gallium-drivers=auto  \
        -D vulkan-drivers=auto   \
        -D valgrind=disabled     \
        -D libunwind=disabled
}

k_build() {
  ninja
}

k_check() {
  meson configure -D build-tests=true
  ninja test
}

k_install() {
  ninja install
}

k_post_install() {
  cp -rv ../docs -T /usr/share/doc/mesa-24.1.5
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
  mkdir -p $KPKG_TMP_DIR/usr/share/doc/
  cp -rv ../docs -T $KPKG_TMP_DIR/usr/share/doc/mesa-24.1.5
}
