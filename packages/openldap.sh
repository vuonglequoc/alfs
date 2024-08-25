#!/bin/bash

KPKG_SRC_FILE=openldap-2.6.8.tgz
KPKG_SRC_FOLDER=openldap-2.6.8

k_pre_configure() {
  groupadd -g 83 ldap
  useradd  -c "OpenLDAP Daemon Owner" \
          -d /var/lib/openldap -u 83 \
          -g ldap -s /bin/false ldap

  patch -Np1 -i ../openldap-2.6.8-consolidated-1.patch
  autoconf
}

k_configure() {
  ./configure --prefix=/usr         \
              --sysconfdir=/etc     \
              --localstatedir=/var  \
              --libexecdir=/usr/lib \
              --disable-static      \
              --disable-debug       \
              --with-tls=openssl    \
              --with-cyrus-sasl     \
              --without-systemd     \
              --enable-dynamic      \
              --enable-crypt        \
              --enable-spasswd      \
              --enable-slapd        \
              --enable-modules      \
              --enable-rlookups     \
              --enable-backends=mod \
              --disable-sql         \
              --disable-wt          \
              --enable-overlays=mod
}

k_build() {
  make depend
  make
}

k_check() {
  make test
}

k_install() {
  make install

  sed -e "s/\.la/.so/" -i /etc/openldap/slapd.{conf,ldif}{,.default}

  install -v -dm700 -o ldap -g ldap /var/lib/openldap

  install -v -dm700 -o ldap -g ldap /etc/openldap/slapd.d
  chmod   -v    640     /etc/openldap/slapd.{conf,ldif}
  chown   -v  root:ldap /etc/openldap/slapd.{conf,ldif}

  install -v -dm755 /usr/share/doc/openldap-2.6.8
  cp      -vfr      doc/{drafts,rfc,guide} \
                    /usr/share/doc/openldap-2.6.8
}

k_post_install() {
  cd $KPKG_ROOT/sources
  tar -xf blfs-bootscripts-20240416.tar.xz
  cd blfs-bootscripts-20240416
  make install-slapd
  cd $KPKG_ROOT/sources
  rm -r blfs-bootscripts-20240416

  # Testing the Configuration
  /etc/rc.d/init.d/slapd start
  ldapsearch -x -b '' -s base '(objectclass=*)' namingContexts

  # The expected result is:

  # # extended LDIF
  # #
  # # LDAPv3
  # # base <> with scope baseObject
  # # filter: (objectclass=*)
  # # requesting: namingContexts
  # #

  # #
  # dn:
  # namingContexts: dc=my-domain,dc=com

  # # search result
  # search: 2
  # result: 0 Success

  # # numResponses: 2
  # # numEntries: 1
}

k_pre_record() {
  cd $KPKG_ROOT/sources/$KPKG_SRC_FOLDER
  make DESTDIR=$KPKG_TMP_DIR install

  sed -e "s/\.la/.so/" -i $KPKG_TMP_DIR/etc/openldap/slapd.{conf,ldif}{,.default}

  install -v -dm700 -o ldap -g ldap $KPKG_TMP_DIR/var/lib/openldap

  install -v -dm700 -o ldap -g ldap $KPKG_TMP_DIR/etc/openldap/slapd.d
  chmod   -v    640     $KPKG_TMP_DIR/etc/openldap/slapd.{conf,ldif}
  chown   -v  root:ldap $KPKG_TMP_DIR/etc/openldap/slapd.{conf,ldif}

  install -v -dm755 $KPKG_TMP_DIR/usr/share/doc/openldap-2.6.8
  cp      -vfr      doc/{drafts,rfc,guide} \
                    $KPKG_TMP_DIR/usr/share/doc/openldap-2.6.8

  cd $KPKG_ROOT/sources
  tar -xf blfs-bootscripts-20240416.tar.xz
  cd blfs-bootscripts-20240416
  make DESTDIR=$KPKG_TMP_DIR install-slapd
  cd $KPKG_ROOT/sources
  rm -r blfs-bootscripts-20240416
}
