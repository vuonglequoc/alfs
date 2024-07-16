#!/bin/bash

KPKG_SRC_FILE=less-643.tar.gz
KPKG_SRC_FOLDER=less-643

k_configure() {
  ./configure --prefix=/usr \
              --sysconfdir=/etc
}
