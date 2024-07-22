#!/bin/bash

KPKG_SRC_FILE=Net-SSLeay-1.94.tar.gz
KPKG_SRC_FOLDER=Net-SSLeay-1.94

k_configure() {
  yes '' | perl Makefile.PL
}

k_check() {
  make test
}
