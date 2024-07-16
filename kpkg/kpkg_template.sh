#!/bin/bash

KPKG_DIR=$KPKG_ROOT/etc/kpkg
KPKG_TMP_DIR=$KPKG_DIR/tmp
KPKG_SRC_FILE=
KPKG_SRC_FOLDER=

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
  make DESTDIR=$KPKG_TMP_DIR install
}

k_record() {
  pushd $KPKG_TMP_DIR
    find . -type f > $KPKG_DIR/$KPKG_SRC_FOLDER.dest
    sed -i "s/.\//\//" $KPKG_DIR/$KPKG_SRC_FOLDER.dest
    rm -rf ./*
  popd
}
