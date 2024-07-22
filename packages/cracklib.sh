#!/bin/bash

KPKG_SRC_FILE=cracklib-2.10.0.tar.xz
KPKG_SRC_FOLDER=cracklib-2.10.0

k_pre_configure() {
  autoreconf -fiv
}

k_configure() {
  PYTHON=python3               \
  ./configure --prefix=/usr    \
              --disable-static \
              --with-default-dict=/usr/lib/cracklib/pw_dict
}

k_check() {
  make test
}

k_post_install() {
  install -v -m644 -D    ../cracklib-words-2.10.0.xz \
                           /usr/share/dict/cracklib-words.xz

  unxz -v                  /usr/share/dict/cracklib-words.xz
  ln -v -sf cracklib-words /usr/share/dict/words
  echo $(hostname) >>      /usr/share/dict/cracklib-extra-words
  install -v -m755 -d      /usr/lib/cracklib

  create-cracklib-dict     /usr/share/dict/cracklib-words \
                           /usr/share/dict/cracklib-extra-words
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -v -m755 -d      $KPKG_TMP_DIR/usr/share/dict/
  cp /usr/share/dict/cracklib-words $KPKG_TMP_DIR/usr/share/dict/cracklib-words
  ln -v -sf cracklib-words $KPKG_TMP_DIR/usr/share/dict/words
  cp /usr/share/dict/cracklib-extra-words $KPKG_TMP_DIR/usr/share/dict/cracklib-extra-words
  install -v -m755 -d      $KPKG_TMP_DIR/usr/lib/cracklib
}
