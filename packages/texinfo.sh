#!/bin/bash

KPKG_SRC_FILE=texinfo-7.1.tar.xz
KPKG_SRC_FOLDER=texinfo-7.1

k_configure() {
  ./configure --prefix=/usr
}

k_post_install() {
  make TEXMF=/usr/share/texmf install-tex

  pushd /usr/share/info
    rm -v dir
    for f in *
      do install-info $f dir 2>/dev/null
    done
  popd
}
