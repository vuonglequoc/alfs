#!/bin/bash

KPKG_SRC_FILE=IO-Socket-SSL-2.088.tar.gz
KPKG_SRC_FOLDER=IO-Socket-SSL-2.088

k_configure() {
  yes '' | perl Makefile.PL
}

k_check() {
  make test
}
