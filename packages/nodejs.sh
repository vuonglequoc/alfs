#!/bin/bash

KPKG_SRC_FILE=node-v20.16.0.tar.xz
KPKG_SRC_FOLDER=node-v20.16.0

k_configure() {
  ./configure --prefix=/usr          \
              --shared-brotli        \
              --shared-cares         \
              --shared-libuv         \
              --shared-openssl       \
              --shared-nghttp2       \
              --shared-zlib          \
              --with-intl=system-icu
}

k_check() {
  make test-only
}

k_post_install() {
  ln -sf node /usr/share/doc/node-20.16.0
}
