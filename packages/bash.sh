#!/bin/bash

KPKG_SRC_FILE=bash-5.2.32.tar.gz
KPKG_SRC_FOLDER=bash-5.2.32

k_configure() {
  ./configure --prefix=/usr             \
              --without-bash-malloc     \
              --with-installed-readline \
              bash_cv_strtold_broken=no \
              --docdir=/usr/share/doc/bash-5.2.32
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
