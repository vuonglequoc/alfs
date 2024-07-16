#!/bin/bash

KPKG_SRC_FILE=popt-1.19.tar.gz
KPKG_SRC_FOLDER=popt-1.19

k_configure() {
  ./configure --prefix=/usr \
              --disable-static
}
