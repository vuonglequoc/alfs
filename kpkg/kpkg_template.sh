#!/bin/bash

KPKG_DIR=$KPKG_ROOT/etc/kpkg
KPKG_TMP_DIR=$KPKG_DIR/tmp
KPKG_SRC_FILE=
KPKG_SRC_FOLDER=

k_prepare_source() {
  cd $KPKG_ROOT/sources
  tar xvf $KPKG_SRC_FILE
  cd $KPKG_SRC_FOLDER
}

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

k_build_clean() {
  cd $KPKG_ROOT/sources
  rm -rf $KPKG_SRC_FOLDER
  echo Deleting $KPKG_SRC_FOLDER
}
