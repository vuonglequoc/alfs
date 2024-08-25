#!/bin/bash

KPKG_SRC_FILE=sudo-1.9.15p5.tar.gz
KPKG_SRC_FOLDER=sudo-1.9.15p5

k_configure() {
  ./configure --prefix=/usr                         \
              --libexecdir=/usr/lib                 \
              --with-secure-path                    \
              --with-env-editor                     \
              --docdir=/usr/share/doc/sudo-1.9.15p5 \
              --with-passprompt="[sudo] password for %p: "
}

k_check() {
  env LC_ALL=C make check |& tee make-check.log
}

k_post_install() {
cat > /etc/sudoers.d/00-sudo << "EOF"
Defaults secure_path="/usr/sbin:/usr/bin"
%wheel ALL=(ALL) ALL
EOF
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR install

  cp -v /etc/sudoers.d/00-sudo $KPKG_TMP_DIR/etc/sudoers.d/00-sudo
}
