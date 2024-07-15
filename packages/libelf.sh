#!/bin/bash

SRC_FILE=elfutils-0.190.tar.bz2
SRC_FOLDER=elfutils-0.190

k_configure() {
  ./configure --prefix=/usr        \
              --disable-debuginfod \
              --enable-libdebuginfod=dummy
}

k_install() {
  make -C libelf install
}

k_post_install() {
  install -vm644 config/libelf.pc /usr/lib/pkgconfig
  rm /usr/lib/libelf.a
}

k_pre_record() {
  make DESTDIR=$KPKG_DEST_DIR -C libelf install

  mkdir -p $KPKG_DEST_DIR/usr/lib/pkgconfig
  install -vm644 config/libelf.pc $KPKG_DEST_DIR/usr/lib/pkgconfig
  rm $KPKG_DEST_DIR/usr/lib/libelf.a
}
