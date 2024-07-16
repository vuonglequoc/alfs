#!/bin/bash

KPKG_SRC_FILE=expect5.45.4.tar.gz
KPKG_SRC_FOLDER=expect5.45.4

k_pre_configure() {
  python3 -c 'from pty import spawn; spawn(["echo", "ok"])'
}

k_configure() {
  ./configure --prefix=/usr           \
              --with-tcl=/usr/lib     \
              --enable-shared         \
              --mandir=/usr/share/man \
              --with-tclinclude=/usr/include
}

k_check() {
  make test
}

k_post_install() {
  ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib
}
