#!/bin/bash

KPKG_SRC_FILE=less-661.tar.gz
KPKG_SRC_FOLDER=less-661

k_configure() {
  ./configure --prefix=/usr \
              --sysconfdir=/etc
}
