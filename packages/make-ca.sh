#!/bin/bash

KPKG_SRC_FILE=make-ca-1.14.tar.gz
KPKG_SRC_FOLDER=make-ca-1.14

k_configure() {
  :
}

k_build() {
  :
}

k_check() {
  :
}

k_install() {
  make install
  install -vdm755 /etc/ssl/local
}

k_post_install() {
/usr/sbin/make-ca -g

cat > /etc/cron.weekly/update-pki.sh << "EOF" &&
#!/bin/bash
/usr/sbin/make-ca -g
EOF
chmod 754 /etc/cron.weekly/update-pki.sh

mkdir -pv /etc/profile.d &&
cat > /etc/profile.d/pythoncerts.sh << "EOF"
# Begin /etc/profile.d/pythoncerts.sh

export _PIP_STANDALONE_CERT=/etc/pki/tls/certs/ca-bundle.crt

# End /etc/profile.d/pythoncerts.sh
EOF
}

k_pre_record() {
  mkdir -p $KPKG_TMP_DIR/etc/ssl/
  mkdir -p $KPKG_TMP_DIR/etc/pki/
  mkdir -p $KPKG_TMP_DIR/etc/cron.weekly/
  mkdir -p $KPKG_TMP_DIR/etc/profile.d/
  cp -r /etc/ssl/{certs,local} $KPKG_TMP_DIR/etc/ssl/
  cp -r /etc/pki/{anchors,tls/{certs,java}} $KPKG_TMP_DIR/etc/pki/
  cp /etc/cron.weekly/update-pki.sh $KPKG_TMP_DIR/etc/cron.weekly/update-pki.sh
  cp /etc/profile.d/pythoncerts.sh $KPKG_TMP_DIR/etc/profile.d/pythoncerts.sh
}
