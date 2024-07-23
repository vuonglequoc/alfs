#!/bin/bash

KPKG_SRC_FILE=packaging-24.1.tar.gz
KPKG_SRC_FOLDER=packaging-24.1

k_configure() {
  :
}

k_build() {
  pip3 wheel -w dist --no-build-isolation --no-deps --no-cache-dir $PWD
}

k_check() {
  :
}

k_install() {
  pip3 install --no-index --find-links=dist --no-cache-dir --no-user packaging
}

k_pre_record() {
  :
}

k_record() {
  :
}
