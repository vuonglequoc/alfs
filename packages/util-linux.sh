#!/bin/bash

KPKG_SRC_FILE=util-linux-2.40.2.tar.xz
KPKG_SRC_FOLDER=util-linux-2.40.2

k_configure() {
  ./configure --bindir=/usr/bin     \
              --libdir=/usr/lib     \
              --runstatedir=/run    \
              --sbindir=/usr/sbin   \
              --disable-chfn-chsh   \
              --disable-login       \
              --disable-nologin     \
              --disable-su          \
              --disable-setpriv     \
              --disable-runuser     \
              --disable-pylibmount  \
              --disable-liblastlog2 \
              --disable-static      \
              --without-python      \
              --without-systemd     \
              --without-systemdsystemunitdir        \
              ADJTIME_PATH=/var/lib/hwclock/adjtime \
              --docdir=/usr/share/doc/util-linux-2.40.2
}

k_check() {
  touch /etc/fstab
  chown -R tester .
  su tester -c "make -k check"
}
