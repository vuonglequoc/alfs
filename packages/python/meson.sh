#!/bin/bash

KPKG_SRC_FILE=meson-1.3.2.tar.gz
KPKG_SRC_FOLDER=meson-1.3.2

k_configure() {
  :
}

k_build() {
  pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
}

k_check() {
  :
}

k_pre_install() {
  pip3 install --no-index --find-links dist meson

  install -vDm644 data/shell-completions/bash/meson $KPKG_TMP_DIR/usr/share/bash-completion/completions/meson
  install -vDm644 data/shell-completions/zsh/_meson $KPKG_TMP_DIR/usr/share/zsh/site-functions/_meson
}
