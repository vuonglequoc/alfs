#!/bin/bash

KPKG_SRC_FILE=curl-8.8.0.tar.xz
KPKG_SRC_FOLDER=curl-8.8.0

k_configure() {
  ./configure --prefix=/usr              \
              --disable-static           \
              --with-openssl             \
              --enable-threaded-resolver \
              --with-ca-path=/etc/ssl/certs
}

k_check() {
  make test
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  rm -rf docs/examples/.deps

  find docs \( -name Makefile\* -o  \
               -name \*.1       -o  \
               -name \*.3       -o  \
               -name CMakeLists.txt \) -delete

  cp -v -R docs -T $KPKG_TMP_DIR/usr/share/doc/curl-8.8.0
}

k_post_install() {
  curl --trace-ascii debugdump.txt https://www.example.com/
  curl --trace-ascii d.txt --trace-time https://example.com/
}
