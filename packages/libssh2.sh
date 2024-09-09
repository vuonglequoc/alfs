#!/bin/bash

KPKG_SRC_FILE=libssh2-1.11.0.tar.gz
KPKG_SRC_FOLDER=libssh2-1.11.0

k_pre_configure() {
  patch -Np1 -i ../libssh2-1.11.0-security_fixes-1.patch

  sed -E '/^DOCKER_TEST/,/^SSHD_TEST/s/test_(auth_keyboard_info.* |hostkey |simple)/$(NOTHING)/' \
      -i tests/Makefile.inc
  autoreconf -fi
  sed 's/ssh-dss,//' -i tests/openssh_server/sshd_config
}

k_configure() {
  ./configure --prefix=/usr          \
              --disable-docker-tests \
              --disable-static
}
