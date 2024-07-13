#!/bin/bash

SRC_FILE=bash-5.2.21.tar.gz
SRC_FOLDER=bash-5.2.21

k_pre_configure() {
  patch -Np1 -i ../bash-5.2.21-upstream_fixes-1.patch
}

k_configure() {
  ./configure --prefix=/usr             \
              --without-bash-malloc     \
              --with-installed-readline \
              --docdir=/usr/share/doc/bash-5.2.21
}

k_check() {
chown -Rv tester .
su -s /usr/bin/expect tester << "EOF"
set timeout -1
spawn make tests
expect eof
lassign [wait] _ _ _ value
exit $value
EOF
}

# Run new bash will break current alfs-script
# k_post_install() {
#   exec /usr/bin/bash --login
# }
