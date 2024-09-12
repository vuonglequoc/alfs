#!/bin/bash

KPKG_SRC_FILE=gettext-0.22.5.tar.xz
KPKG_SRC_FOLDER=gettext-0.22.5

k_configure() {
  ./configure --disable-shared
}

k_check() {
  :
}

k_pre_install() {
  mkdir -p $KPKG_TMP_DIR/usr/bin
  cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} $KPKG_TMP_DIR/usr/bin
}
