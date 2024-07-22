#!/bin/bash

KPKG_SRC_FILE=Cython-3.0.10.tar.gz
KPKG_SRC_FOLDER=Cython-3.0.10

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
  pip3 install --no-index --find-links=dist --no-cache-dir --no-user Cython
}

k_pre_record() {
  :
}

k_record() {
  :
}
