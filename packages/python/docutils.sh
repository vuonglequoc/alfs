#!/bin/bash

KPKG_SRC_FILE=docutils-0.21.2.tar.gz
KPKG_SRC_FOLDER=docutils-0.21.2

k_pre_configure() {
  for f in /usr/bin/rst*.py; do
    rm -fv /usr/bin/$(basename $f .py)
  done
}

k_configure() {
  :
}

k_build() {
  pip3 wheel -w dist --no-build-isolation --no-deps --no-cache-dir $PWD
}

k_check() {
  :
}

k_pre_install() {
  :
}

k_install() {
  pip3 install --no-index --find-links=dist --no-cache-dir --no-user docutils
}
