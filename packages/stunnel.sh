#!/bin/bash

KPKG_SRC_FILE=stunnel-5.72.tar.gz
KPKG_SRC_FOLDER=stunnel-5.72

k_pre_configure() {
  groupadd -g 51 stunnel
  useradd -c "stunnel Daemon" -d /var/lib/stunnel \
          -g stunnel -s /bin/false -u 51 stunnel
}

k_configure() {
  ./configure --prefix=/usr        \
              --sysconfdir=/etc    \
              --localstatedir=/var \
              --disable-systemd
}

k_install() {
  make docdir=/usr/share/doc/stunnel-5.72 install
}

k_post_install() {
# generate A signed SSL Certificate and a Private Key
echo -e "US\nIllinois\nChicago\nStunnel Developers\nProvisional CA\nlocalhost\n" | make cert
# Country Name (2 letter code) [PL]:
# State or Province Name (full name) [Mazovia Province]:
# Locality Name (eg, city) [Warsaw]:
# Organization Name (eg, company) [Stunnel Developers]:
# Organizational Unit Name (eg, section) [Provisional CA]:
# Common Name (FQDN of your server) [localhost]:
# /etc/stunnel/stunnel.pem

install -v -m750 -o stunnel -g stunnel -d /var/lib/stunnel/run
chown stunnel:stunnel /var/lib/stunnel

cat > /etc/stunnel/stunnel.conf << "EOF"
; File: /etc/stunnel/stunnel.conf

; Note: The pid and output locations are relative to the chroot location.

pid    = /run/stunnel.pid
chroot = /var/lib/stunnel
client = no
setuid = stunnel
setgid = stunnel
cert   = /etc/stunnel/stunnel.pem

;debug = 7
;output = stunnel.log

;[https]
;accept  = 443
;connect = 80
;; "TIMEOUTclose = 0" is a workaround for a design flaw in Microsoft SSL
;; Microsoft implementations do not use SSL close-notify alert and thus
;; they are vulnerable to truncation attacks
;TIMEOUTclose = 0

EOF

cd $KPKG_ROOT/sources
tar -xf blfs-bootscripts-20240416.tar.xz
cd blfs-bootscripts-20240416
make install-stunnel
cd $KPKG_ROOT/sources
rm -r blfs-bootscripts-20240416
}

k_pre_record() {
  cd $KPKG_ROOT/sources/$KPKG_SRC_FOLDER
  make DESTDIR=$KPKG_TMP_DIR docdir=/usr/share/doc/stunnel-5.72 install

  mkdir /etc/stunnel
  cp /etc/stunnel/* $KPKG_TMP_DIR/etc/stunnel/

  cd $KPKG_ROOT/sources
  tar -xf blfs-bootscripts-20240416.tar.xz
  cd blfs-bootscripts-20240416
  make DESTDIR=$KPKG_TMP_DIR install-stunnel
  cd $KPKG_ROOT/sources
  rm -r blfs-bootscripts-20240416
}
