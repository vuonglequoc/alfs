#!/bin/bash

KPKG_SRC_FILE=libevent-2.1.12-stable.tar.gz
KPKG_SRC_FOLDER=libevent-2.1.12-stable

k_pre_configure() {
  sed -i 's/python/&3/' event_rpcgen.py
}

k_configure() {
  ./configure --prefix=/usr --disable-static
}

k_check() {
  make verify
}
