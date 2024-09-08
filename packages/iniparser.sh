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
  sudo mkdir -p $KPKG_TMP_DIR/usr/include/iniparser/
  sudo cp src/*.h $KPKG_TMP_DIR/usr/include/iniparser/
  sudo cp libiniparser.* $KPKG_TMP_DIR/usr/lib/
  sudo ln -svf libiniparser.so.1 $KPKG_TMP_DIR/usr/lib/libiniparser.so
}
