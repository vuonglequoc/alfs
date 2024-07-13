#!/bin/bash

SRC_FILE=sysklogd-1.5.1.tar.gz
SRC_FOLDER=sysklogd-1.5.1

k_pre_configure() {
  sed -i '/Error loading kernel symbols/{n;n;d}' ksym_mod.c
  sed -i 's/union wait/int/' syslogd.c
}

k_configure() {
  :
}

k_check() {
  :
}

k_install() {
  make BINDIR=/sbin install
}

k_post_install() {
cat > /etc/syslog.conf << "EOF"
# Begin /etc/syslog.conf

auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

# End /etc/syslog.conf
EOF
}
