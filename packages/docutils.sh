#!/bin/bash

KPKG_SRC_FILE=docutils-0.21.2.tar.gz
KPKG_SRC_FOLDER=docutils-0.21.2

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
  pip3 install --no-index --find-links=dist --no-cache-dir --no-user docutils
}

k_post_install() {
  for f in /usr/bin/rst*.py; do
    ln -svf $(basename $f) /usr/bin/$(basename $f .py)
  done

  rm -rfv /usr/bin/__pycache__
}

k_pre_record() {
  :
}

k_record() {
  :
}
