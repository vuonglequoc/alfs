#!/bin/bash

KPKG_SRC_FILE=vlc-3.0.21.tar.xz
KPKG_SRC_FOLDER=vlc-3.0.21

k_pre_configure() {
  patch -Np1 -i ../vlc-3.0.21-taglib-1.patch
  patch -Np1 -i ../vlc-3.0.21-fedora_ffmpeg7-1.patch

  export LUAC=/usr/bin/luac5.2
  export LUA_LIBS="$(pkg-config --libs lua52)"
  export CPPFLAGS="$(pkg-config --cflags lua52)"
}

k_configure() {
  # disable support for using libplacebo as a rendering pipeline
  # because VLC is incompatible with the latest version of libplacebo.
  BUILDCC=gcc ./configure           \
              --prefix=/usr         \
              --disable-libplacebo  \
              --disable-xcb
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR docdir=/usr/share/doc/vlc-3.0.21 install
}
