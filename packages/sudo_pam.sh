#!/bin/bash

KPKG_SRC_FILE=sudo-1.9.15p5.tar.gz
KPKG_SRC_FOLDER=sudo-1.9.15p5

k_configure() {
  ./configure --prefix=/usr                         \
              --libexecdir=/usr/lib                 \
              --with-secure-path                    \
              --with-env-editor                     \
              --docdir=/usr/share/doc/sudo-1.9.15p5 \
              --with-passprompt="[sudo] password for %p: "
}

k_check() {
  env LC_ALL=C make check |& tee make-check.log
}

k_pre_install() {
make DESTDIR=$KPKG_TMP_DIR install

mkdir -pv $KPKG_TMP_DIR/etc/sudoers.d
cat > $KPKG_TMP_DIR/etc/sudoers.d/00-sudo << "EOF"
Defaults secure_path="/usr/sbin:/usr/bin"
%wheel ALL=(ALL) ALL
EOF

mkdir $KPKG_TMP_DIR/etc/pam.d
cat > $KPKG_TMP_DIR/etc/pam.d/sudo << "EOF"
# Begin /etc/pam.d/sudo

# include the default auth settings
auth      include     system-auth

# include the default account settings
account   include     system-account

# Set default environment variables for the service user
session   required    pam_env.so

# include system session defaults
session   include     system-session

# End /etc/pam.d/sudo
EOF
chmod 644 $KPKG_TMP_DIR/etc/pam.d/sudo
}
