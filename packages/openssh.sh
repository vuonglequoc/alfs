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

k_post_install() {
  install -v -m755    contrib/ssh-copy-id /usr/bin

  install -v -m644    contrib/ssh-copy-id.1 \
                      /usr/share/man/man1
  install -v -m755 -d /usr/share/doc/openssh-9.8p1
  install -v -m644    INSTALL LICENCE OVERVIEW README* \
                      /usr/share/doc/openssh-9.8p1

  echo "PermitRootLogin no" >> /etc/ssh/sshd_config

  # disable password logins
  # echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
  # echo "KbdInteractiveAuthentication no" >> /etc/ssh/sshd_config

  # start the SSH server at system boot
  cd $KPKG_ROOT/sources
  tar -xf blfs-bootscripts-20240416.tar.xz
  cd blfs-bootscripts-20240416
  make install-sshd
  cd $KPKG_ROOT/sources
  rm -r blfs-bootscripts-20240416
}

k_pre_record() {
  cp -v /var/lib/sshd $KPKG_TMP_DIR/var/lib/sshd

  make DESTDIR=$KPKG_TMP_DIR install

  install -v -m755    contrib/ssh-copy-id $KPKG_TMP_DIR/usr/bin

  install -v -m644    contrib/ssh-copy-id.1 \
                      $KPKG_TMP_DIR/usr/share/man/man1
  install -v -m755 -d $KPKG_TMP_DIR/usr/share/doc/openssh-9.8p1
  install -v -m644    INSTALL LICENCE OVERVIEW README* \
                      $KPKG_TMP_DIR/usr/share/doc/openssh-9.8p1

  cp -v /etc/ssh/sshd_config $KPKG_TMP_DIR/etc/ssh/sshd_config

  cd $KPKG_ROOT/sources
  tar -xf blfs-bootscripts-20240416.tar.xz
  cd blfs-bootscripts-20240416

  install -d -m 755 $KPKG_TMP_DIR/etc/rc.d/rc{0,1,2,3,4,5,6,S}.d
  install -d -m 755 $KPKG_TMP_DIR/etc/rc.d/init.d
  install -d -m 755 $KPKG_TMP_DIR/etc/sysconfig
  install -m 754 blfs/init.d/sshd       $KPKG_TMP_DIR/etc/rc.d/init.d/
  ln -sf  ../init.d/sshd $KPKG_TMP_DIR/etc/rc.d/rc0.d/K30sshd
  ln -sf  ../init.d/sshd $KPKG_TMP_DIR/etc/rc.d/rc1.d/K30sshd
  ln -sf  ../init.d/sshd $KPKG_TMP_DIR/etc/rc.d/rc2.d/S30sshd
  ln -sf  ../init.d/sshd $KPKG_TMP_DIR/etc/rc.d/rc3.d/S30sshd
  ln -sf  ../init.d/sshd $KPKG_TMP_DIR/etc/rc.d/rc4.d/S30sshd
  ln -sf  ../init.d/sshd $KPKG_TMP_DIR/etc/rc.d/rc5.d/S30sshd
  ln -sf  ../init.d/sshd $KPKG_TMP_DIR/etc/rc.d/rc6.d/K30sshd

  cd $KPKG_ROOT/sources
  rm -r blfs-bootscripts-20240416
}
