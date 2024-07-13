#!/bin/bash

SRC_FILE=util-linux-2.39.3.tar.xz
SRC_FOLDER=util-linux-2.39.3

k_pre_configure() {
  mkdir -pv /var/lib/hwclock
}

k_configure() {
  ./configure --libdir=/usr/lib                     \
              --runstatedir=/run                    \
              --disable-chfn-chsh                   \
              --disable-login                       \
              --disable-nologin                     \
              --disable-su                          \
              --disable-setpriv                     \
              --disable-runuser                     \
              --disable-pylibmount                  \
              --disable-static                      \
              --without-python                      \
              ADJTIME_PATH=/var/lib/hwclock/adjtime \
              --docdir=/usr/share/doc/util-linux-2.39.3
}

k_check() {
  :
}
