#!/bin/bash

KPKG_SRC_FILE=pcre2-10.44.tar.bz2
KPKG_SRC_FOLDER=pcre2-10.44

k_configure() {
  ./configure --prefix=/usr                       \
              --docdir=/usr/share/doc/pcre2-10.44 \
              --enable-unicode                    \
              --enable-jit                        \
              --enable-pcre2-16                   \
              --enable-pcre2-32                   \
              --enable-pcre2grep-libz             \
              --enable-pcre2grep-libbz2           \
              --enable-pcre2test-libreadline      \
              --disable-static
}
