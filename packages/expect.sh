#!/bin/bash

KPKG_SRC_FILE=expect5.45.4.tar.gz
KPKG_SRC_FOLDER=expect5.45.4

k_pre_configure() {
  python3 -c 'from pty import spawn; spawn(["echo", "ok"])'

  patch -Np1 -i ../expect-5.45.4-gcc14-1.patch
}

k_configure() {
  ./configure --prefix=/usr           \
              --with-tcl=/usr/lib     \
              --enable-shared         \
              --disable-rpath         \
              --mandir=/usr/share/man \
              --with-tclinclude=/usr/include
}

k_check() {
  make test
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  ln -svf expect5.45.4/libexpect5.45.4.so $KPKG_TMP_DIR/usr/lib/libexpect5.45.4.so
}
