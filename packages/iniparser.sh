#!/bin/bash

KPKG_SRC_FILE=iniparser-4.2.1.tar.gz
KPKG_SRC_FOLDER=iniparser-4.2.1

k_configure() {
  :
}

k_check() {
  :
}

k_pre_install() {
  mkdir -pv $KPKG_TMP_DIR/usr/include/iniparser/
  cp src/*.h $KPKG_TMP_DIR/usr/include/iniparser/

  mkdir -pv $KPKG_TMP_DIR/usr/lib
  cp libiniparser.* $KPKG_TMP_DIR/usr/lib/

  ln -svf libiniparser.so.1 $KPKG_TMP_DIR/usr/lib/libiniparser.so
}
