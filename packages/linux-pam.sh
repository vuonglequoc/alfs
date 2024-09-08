#!/bin/bash

KPKG_SRC_FILE=Linux-PAM-1.6.1.tar.xz
KPKG_SRC_FOLDER=Linux-PAM-1.6.1

k_pre_configure() {
  sed -e /service_DATA/d \
    -i modules/pam_namespace/Makefile.am
  autoreconf

  tar -xf ../Linux-PAM-1.6.1-docs.tar.xz --strip-components=1
}

k_configure() {
  ./configure --prefix=/usr                        \
              --sbindir=/usr/sbin                  \
              --sysconfdir=/etc                    \
              --libdir=/usr/lib                    \
              --enable-securedir=/usr/lib/security \
              --docdir=/usr/share/doc/Linux-PAM-1.6.1
}

k_check() {
install -v -m755 -d /etc/pam.d

cat > /etc/pam.d/other << "EOF"
auth     required       pam_deny.so
account  required       pam_deny.so
password required       pam_deny.so
session  required       pam_deny.so
EOF

make check

rm -fv /etc/pam.d/other
}

k_pre_install() {
make DESTDIR=$KPKG_TMP_DIR install
chmod -v 4755 $KPKG_TMP_DIR/usr/sbin/unix_chkpwd

install -vdm755 $KPKG_TMP_DIR/etc/pam.d

cat > $KPKG_TMP_DIR/etc/pam.d/system-account << "EOF"
# Begin /etc/pam.d/system-account

account   required    pam_unix.so

# End /etc/pam.d/system-account
EOF

cat > $KPKG_TMP_DIR/etc/pam.d/system-auth << "EOF"
# Begin /etc/pam.d/system-auth

auth      required    pam_unix.so

# End /etc/pam.d/system-auth
EOF

cat > $KPKG_TMP_DIR/etc/pam.d/system-session << "EOF"
# Begin /etc/pam.d/system-session

session   required    pam_unix.so

# End /etc/pam.d/system-session
EOF

cat > $KPKG_TMP_DIR/etc/pam.d/system-password << "EOF"
# Begin /etc/pam.d/system-password

# use yescrypt hash for encryption, use shadow, and try to use any
# previously defined authentication token (chosen password) set by any
# prior module.
password  required    pam_unix.so       yescrypt shadow try_first_pass

# End /etc/pam.d/system-password
EOF

cat > $KPKG_TMP_DIR/etc/pam.d/other << "EOF"
# Begin /etc/pam.d/other

auth        required        pam_warn.so
auth        required        pam_deny.so
account     required        pam_warn.so
account     required        pam_deny.so
password    required        pam_warn.so
password    required        pam_deny.so
session     required        pam_warn.so
session     required        pam_deny.so

# End /etc/pam.d/other
EOF
}
