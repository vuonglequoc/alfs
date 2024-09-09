#!/bin/bash

KPKG_SRC_FILE=sysklogd-2.6.1.tar.gz
KPKG_SRC_FOLDER=sysklogd-2.6.1

k_configure() {
  ./configure --prefix=/usr      \
              --sysconfdir=/etc  \
              --runstatedir=/run \
              --without-logger
}

k_check() {
  :
}

k_pre_install() {
make DESTDIR=$KPKG_TMP_DIR BINDIR=/sbin install

cat > $KPKG_TMP_DIR/etc/syslog.conf << "EOF"
# Begin /etc/syslog.conf

auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

# Do not open any internet ports.
secure_mode 2

# End /etc/syslog.conf
EOF
}
