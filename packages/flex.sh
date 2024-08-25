#!/bin/bash

KPKG_SRC_FILE=flex-2.6.4.tar.gz
KPKG_SRC_FOLDER=flex-2.6.4

k_configure() {
  ./configure --prefix=/usr                      \
              --docdir=/usr/share/doc/flex-2.6.4 \
              --disable-static
}

k_post_install() {
  ln -sv flex   /usr/bin/lex
  ln -sv flex.1 /usr/share/man/man1/lex.1
}
