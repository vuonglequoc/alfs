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

k_pre_install() {
make DESTDIR=$KPKG_TMP_DIR install

install -vdm755 $KPKG_TMP_DIR/etc/ssl/local

cat > $KPKG_TMP_DIR/etc/cron.weekly/update-pki.sh << "EOF"
#!/bin/bash
/usr/sbin/make-ca -g
EOF
chmod 754 $KPKG_TMP_DIR/etc/cron.weekly/update-pki.sh

mkdir -pv $KPKG_TMP_DIR/etc/profile.d
cat > $KPKG_TMP_DIR/etc/profile.d/pythoncerts.sh << "EOF"
# Begin /etc/profile.d/pythoncerts.sh

export _PIP_STANDALONE_CERT=/etc/pki/tls/certs/ca-bundle.crt

# End /etc/profile.d/pythoncerts.sh
EOF
}

k_post_install() {
  /usr/sbin/make-ca -g
}
