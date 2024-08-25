#!/bin/bash

KPKG_SRC_FILE=autoconf-2.72.tar.xz
KPKG_SRC_FOLDER=autoconf-2.72

k_configure() {
  ./configure --prefix=/usr
}
