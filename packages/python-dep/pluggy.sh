#!/bin/bash

KPKG_SRC_FILE=pluggy-1.5.0.tar.gz
KPKG_SRC_FOLDER=pluggy-1.5.0

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
  pip3 install --no-index --find-links=dist --no-cache-dir --no-user pluggy
}

k_pre_record() {
  :
}

k_record() {
  :
}
