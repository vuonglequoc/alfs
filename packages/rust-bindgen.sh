#!/bin/bash

KPKG_SRC_FILE=rust-bindgen-0.69.4.tar.gz
KPKG_SRC_FOLDER=rust-bindgen-0.69.4

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
  install -v -m755 target/release/bindgen $KPKG_TMP_DIR/usr/bin
}
