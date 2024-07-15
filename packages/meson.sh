#!/bin/bash

SRC_FILE=meson-1.3.2.tar.gz
SRC_FOLDER=meson-1.3.2

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
  pip3 install --no-index --find-links dist meson
  install -vDm644 data/shell-completions/bash/meson /usr/share/bash-completion/completions/meson
  install -vDm644 data/shell-completions/zsh/_meson /usr/share/zsh/site-functions/_meson
}

k_pre_record() {
  mkdir -p $KPKG_DEST_DIR/usr/share/bash-completion/completions/
  mkdir -p $KPKG_DEST_DIR/usr/share/zsh/site-functions/
  install -vDm644 data/shell-completions/bash/meson $KPKG_DEST_DIR/usr/share/bash-completion/completions/meson
  install -vDm644 data/shell-completions/zsh/_meson $KPKG_DEST_DIR/usr/share/zsh/site-functions/_meson
}
