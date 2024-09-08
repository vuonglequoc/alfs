#!/bin/bash

KPKG_SRC_FILE=lame-3.100.tar.gz
KPKG_SRC_FOLDER=lame-3.100

k_pre_configure() {
  sed -i -e 's/^\(\s*hardcode_libdir_flag_spec\s*=\).*/\1/' configure
}

k_configure() {
  ./configure --prefix=/usr --enable-mp3rtp --disable-static
}

k_check() {
  LD_LIBRARY_PATH=libmp3lame/.libs make test
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR pkghtmldir=/usr/share/doc/lame-3.100 install
}
