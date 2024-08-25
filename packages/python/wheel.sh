#!/bin/bash

KPKG_SRC_FILE=wheel-0.42.0.tar.gz
KPKG_SRC_FOLDER=wheel-0.42.0

k_configure() {
  :
}

k_build() {
  pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
}

k_check() {
  :
}

k_install() {
  pip3 install --no-index --find-links=dist wheel
}

k_pre_record() {
  :
}

k_record() {
  :
}
