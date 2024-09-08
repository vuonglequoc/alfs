#!/bin/bash
# default pwd is root

KPKG_SRC_FILE=shadow-4.14.5.tar.xz
KPKG_SRC_FOLDER=shadow-4.14.5

k_pre_configure() {
  sed -i 's/groups$(EXEEXT) //' src/Makefile.in
  find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
  find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
  find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;

  sed -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD YESCRYPT:' \
      -e 's:/var/spool/mail:/var/mail:'                   \
      -e '/PATH=/{s@/sbin:@@;s@/bin:@@}'                  \
      -i etc/login.defs

  touch /usr/bin/passwd
}

k_configure() {
  ./configure --sysconfdir=/etc   \
              --disable-static    \
              --with-{b,yes}crypt \
              --without-libbsd    \
              --with-group-name-max-length=32
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR exec_prefix=/usr install
  make DESTDIR=$KPKG_TMP_DIR -C man install-man
}

k_post_install() {
  pwconv
  grpconv

  mkdir -p /etc/default
  useradd -D --gid 999

  sed -i '/MAIL/s/yes/no/' /etc/default/useradd

  # passwd root
  echo 'root:root' | chpasswd
}
