#!/bin/bash

SRC_FILE=MarkupSafe-2.1.5.tar.gz
SRC_FOLDER=MarkupSafe-2.1.5

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
  pip3 install --no-index --no-user --find-links dist Markupsafe
}
