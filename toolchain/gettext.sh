#!/bin/bash

KPKG_SRC_FILE=gettext-0.22.4.tar.xz
KPKG_SRC_FOLDER=gettext-0.22.4

k_configure() {
  ./configure --disable-shared
}

k_check() {
  :
}

k_install() {
  cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin
}
