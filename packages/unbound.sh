#!/bin/bash

KPKG_SRC_FILE=unbound-1.20.0.tar.gz
KPKG_SRC_FOLDER=unbound-1.20.0

k_pre_configure() {
  groupadd -g 88 unbound
  useradd -c "Unbound DNS Resolver" -d /var/lib/unbound -u 88 \
          -g unbound -s /bin/false unbound
}

k_configure() {
  ./configure --prefix=/usr     \
              --sysconfdir=/etc \
              --disable-static  \
              --with-pidfile=/run/unbound.pid
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  mv -v $KPKG_TMP_DIR/usr/sbin/unbound-host $KPKG_TMP_DIR/usr/bin/

  echo "nameserver 127.0.0.1" > $KPKG_TMP_DIR/etc/resolv.conf

  cd $KPKG_ROOT/sources
  tar -xf blfs-bootscripts-20240416.tar.xz
  cd blfs-bootscripts-20240416
  make DESTDIR=$KPKG_TMP_DIR install-unbound
  cd $KPKG_ROOT/sources
  rm -r blfs-bootscripts-20240416
}

k_post_install() {
  unbound-anchor
  # /etc/unbound/root.key

  /etc/rc.d/init.d/unbound start
}
