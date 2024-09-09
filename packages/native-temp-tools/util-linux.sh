#!/bin/bash

KPKG_SRC_FILE=util-linux-2.40.2.tar.xz
KPKG_SRC_FOLDER=util-linux-2.40.2

k_pre_configure() {
  mkdir -pv /var/lib/hwclock
}

k_configure() {
  ./configure --libdir=/usr/lib     \
              --runstatedir=/run    \
              --disable-chfn-chsh   \
              --disable-login       \
              --disable-nologin     \
              --disable-su          \
              --disable-setpriv     \
              --disable-runuser     \
              --disable-pylibmount  \
              --disable-static      \
              --disable-liblastlog2 \
              --without-python      \
              ADJTIME_PATH=/var/lib/hwclock/adjtime \
              --docdir=/usr/share/doc/util-linux-2.40.2
}

k_check() {
  :
}
