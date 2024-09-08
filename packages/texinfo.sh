#!/bin/bash

KPKG_SRC_FILE=texinfo-7.1.tar.xz
KPKG_SRC_FOLDER=texinfo-7.1

k_configure() {
  ./configure --prefix=/usr
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  make DESTDIR=$KPKG_TMP_DIR TEXMF=/usr/share/texmf install-tex

  pushd $KPKG_TMP_DIR/usr/share/info
    rm -v dir
    for f in *
      do install-info $f dir 2>/dev/null
    done
  popd
}
