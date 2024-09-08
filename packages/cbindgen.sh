#!/bin/bash

KPKG_SRC_FILE=cbindgen-0.27.0.tar.gz
KPKG_SRC_FOLDER=cbindgen-0.27.0

k_pre_configure() {
  source /etc/profile
}

k_configure() {
  :
}

k_build() {
  cargo build --release
}

k_check() {
  cargo test --release
}

k_pre_install() {
  install -Dm755 target/release/cbindgen $KPKG_TMP_DIR/usr/bin/
}
