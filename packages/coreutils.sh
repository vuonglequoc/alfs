#!/bin/bash

KPKG_SRC_FILE=coreutils-9.5.tar.xz
KPKG_SRC_FOLDER=coreutils-9.5

k_pre_configure() {
  patch -Np1 -i ../coreutils-9.5-i18n-2.patch

  autoreconf -fiv
}

k_configure() {
  FORCE_UNSAFE_CONFIGURE=1  \
  ./configure --prefix=/usr \
              --enable-no-install-program=kill,uptime
}

k_check() {
  make NON_ROOT_USERNAME=tester check-root
  groupadd -g 102 dummy -U tester
  chown -Rv tester .
  su tester -c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check" < /dev/null

  groupdel dummy
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  mv -v $KPKG_TMP_DIR/usr/bin/chroot $KPKG_TMP_DIR/usr/sbin
  mv -v $KPKG_TMP_DIR/usr/share/man/man1/chroot.1 $KPKG_TMP_DIR/usr/share/man/man8/chroot.8
  sed -i 's/"1"/"8"/' $KPKG_TMP_DIR/usr/share/man/man8/chroot.8
}
