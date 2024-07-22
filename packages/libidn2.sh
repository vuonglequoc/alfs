#!/bin/bash

KPKG_SRC_FILE=libidn2-2.3.7.tar.gz
KPKG_SRC_FOLDER=libidn2-2.3.7

k_configure() {
  ./configure --prefix=/usr --disable-static
}
