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

k_install() {
  make install
  mv -v /usr/sbin/unbound-host /usr/bin/
}

k_post_install() {
  echo "nameserver 127.0.0.1" > /etc/resolv.conf
  unbound-anchor
  # /etc/unbound/root.key

  cd $KPKG_ROOT/sources
  tar -xf blfs-bootscripts-20240416.tar.xz
  cd blfs-bootscripts-20240416
  make install-unbound
  cd $KPKG_ROOT/sources
  rm -r blfs-bootscripts-20240416

  /etc/rc.d/init.d/unbound start
}

k_pre_record() {
  cd $KPKG_ROOT/sources/$KPKG_SRC_FOLDER
  make DESTDIR=$KPKG_TMP_DIR install
  mv -v $KPKG_TMP_DIR/usr/sbin/unbound-host $KPKG_TMP_DIR/usr/bin/

  cp /etc/resolv.conf $KPKG_TMP_DIR/etc/resolv.conf
  cp /etc/unbound/root.key $KPKG_TMP_DIR/etc/unbound/root.key

  cd $KPKG_ROOT/sources
  tar -xf blfs-bootscripts-20240416.tar.xz
  cd blfs-bootscripts-20240416
  make DESTDIR=$KPKG_TMP_DIR install-unbound
  cd $KPKG_ROOT/sources
  rm -r blfs-bootscripts-20240416
}
