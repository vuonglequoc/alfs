#!/bin/bash

KPKG_SRC_FILE=trove_classifiers-2024.7.2.tar.gz
KPKG_SRC_FOLDER=trove_classifiers-2024.7.2

k_pre_configure() {
  sed -i '/calver/s/^/#/;$iversion="2024.7.2"' setup.py
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
  pip3 install --no-index --find-links=dist --no-cache-dir --no-user trove-classifiers
}
