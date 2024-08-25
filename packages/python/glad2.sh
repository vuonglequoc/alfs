#!/bin/bash

KPKG_SRC_FILE=glad-2.0.6.tar.gz
KPKG_SRC_FOLDER=glad-2.0.6

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
  pip3 install --no-index --find-links=dist --no-cache-dir --no-user glad2
}

k_pre_record() {
  :
}

k_record() {
  :
}
