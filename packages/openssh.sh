#!/bin/bash

KPKG_SRC_FILE=openssh-9.8p1.tar.gz
KPKG_SRC_FOLDER=openssh-9.8p1

k_pre_configure() {
  install -v -g sys -m700 -d /var/lib/sshd

  groupadd -g 50 sshd
  useradd  -c 'sshd PrivSep' \
           -d /var/lib/sshd  \
           -g sshd           \
           -s /bin/false     \
           -u 50 sshd
}

k_configure() {
  ./configure --prefix=/usr                            \
              --sysconfdir=/etc/ssh                    \
              --with-privsep-path=/var/lib/sshd        \
              --with-default-path=/usr/bin             \
              --with-superuser-path=/usr/sbin:/usr/bin \
              --with-pid-dir=/run
}

k_check() {
  make -j1 tests
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -v -m755    contrib/ssh-copy-id $KPKG_TMP_DIR/usr/bin

  install -v -m644    contrib/ssh-copy-id.1 \
                      $KPKG_TMP_DIR/usr/share/man/man1
  install -v -m755 -d $KPKG_TMP_DIR/usr/share/doc/openssh-9.8p1
  install -v -m644    INSTALL LICENCE OVERVIEW README* \
                      $KPKG_TMP_DIR/usr/share/doc/openssh-9.8p1

  echo "PermitRootLogin no" >> $KPKG_TMP_DIR/etc/ssh/sshd_config

  # Make key for login
  # ssh-keygen &&
  # ssh-copy-id -i ~/.ssh/id_ed25519.pub REMOTE_USERNAME@REMOTE_HOSTNAME

  # disable password logins
  # echo "PasswordAuthentication no" >> $KPKG_TMP_DIR/etc/ssh/sshd_config
  # echo "KbdInteractiveAuthentication no" >> $KPKG_TMP_DIR/etc/ssh/sshd_config

  # start the SSH server at system boot
  cd $KPKG_ROOT/sources
  tar -xf blfs-bootscripts-20240416.tar.xz
  cd blfs-bootscripts-20240416
  make DESTDIR=$KPKG_TMP_DIR install-sshd
  cd $KPKG_ROOT/sources
  rm -r blfs-bootscripts-20240416
}

k_post_install() {
  # Make hostkey
  ssh-keygen -A
}

