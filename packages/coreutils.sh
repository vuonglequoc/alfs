#!/bin/bash

SRC_FILE=coreutils-9.4.tar.xz
SRC_FOLDER=coreutils-9.4

k_pre_configure() {
  patch -Np1 -i ../coreutils-9.4-i18n-1.patch

  sed -e '/n_out += n_hold/,+4 s|.*bufsize.*|//&|' \
      -i src/split.c

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
  su tester -c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check"

  groupdel dummy
}

k_post_install() {
  mv -v /usr/bin/chroot /usr/sbin
  mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
  sed -i 's/"1"/"8"/' /usr/share/man/man8/chroot.8
}
