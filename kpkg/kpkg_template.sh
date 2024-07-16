#!/bin/bash

KPKG_DIR=$KROOT/etc/kpkg
KPKG_DEST_DIR=$KPKG_DIR/tmp
SRC_FILE=
SRC_FOLDER=

k_pre_configure() {
  :
}

k_configure() {
  ./configure
}

k_build() {
  make
}

k_check() {
  make check
}

k_install() {
  make install
}

k_post_install() {
  :
}

k_pre_record() {
  make DESTDIR=$KPKG_DEST_DIR install
}

k_record() {
  pushd $KPKG_DEST_DIR
    find . -type f > $KPKG_DIR/$SRC_FOLDER.dest
    sed -i "s/.\//\//" $KPKG_DIR/$SRC_FOLDER.dest
    rm -rf ./*
  popd
}
