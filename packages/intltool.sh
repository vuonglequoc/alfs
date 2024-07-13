#!/bin/bash

SRC_FILE=intltool-0.51.0.tar.gz
SRC_FOLDER=intltool-0.51.0

k_pre_configure() {
  sed -i 's:\\\${:\\\$\\{:' intltool-update.in
}

k_configure() {
  ./configure --prefix=/usr
}

k_post_install() {
  install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.51.0/I18N-HOWTO
}
