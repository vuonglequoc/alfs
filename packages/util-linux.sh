#!/bin/bash

SRC_FILE=util-linux-2.39.3.tar.xz
SRC_FOLDER=util-linux-2.39.3

k_pre_configure() {
  sed -i '/test_mkfds/s/^/#/' tests/helpers/Makemodule.am
}

k_configure() {
  ./configure --bindir=/usr/bin                     \
              --libdir=/usr/lib                     \
              --runstatedir=/run                    \
              --sbindir=/usr/sbin                   \
              --disable-chfn-chsh                   \
              --disable-login                       \
              --disable-nologin                     \
              --disable-su                          \
              --disable-setpriv                     \
              --disable-runuser                     \
              --disable-pylibmount                  \
              --disable-static                      \
              --without-python                      \
              --without-systemd                     \
              --without-systemdsystemunitdir        \
              ADJTIME_PATH=/var/lib/hwclock/adjtime \
              --docdir=/usr/share/doc/util-linux-2.39.3
}

k_check() {
  chown -Rv tester .
  su tester -c "make -k check"
}
