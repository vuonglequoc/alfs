#!/bin/bash

KPKG_SRC_FILE=libuv-v1.48.0.tar.gz
KPKG_SRC_FOLDER=libuv-v1.48.0

k_pre_configure() {
  sh autogen.sh
}

k_configure() {
  ./configure --prefix=/usr --disable-static
}
