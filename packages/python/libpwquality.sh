#!/bin/bash

KPKG_SRC_FILE=libpwquality-1.4.5.tar.bz2
KPKG_SRC_FOLDER=libpwquality-1.4.5

k_configure() {
  ./configure --prefix=/usr                      \
              --disable-static                   \
              --with-securedir=/usr/lib/security \
              --disable-python-bindings
}

k_build() {
  make
  pip3 wheel -w dist --no-build-isolation --no-deps --no-cache-dir $PWD/python
}

k_check() {
  :
}

k_pre_install() {
make DESTDIR=$KPKG_TMP_DIR install

pip3 install --no-index --find-links=dist --no-cache-dir --no-user pwquality

# Backup old system-password
mv /etc/pam.d/system-password{,.orig}
# Prepare new system-password
mkdir -pv $KPKG_TMP_DIR/etc/pam.d
cat > $KPKG_TMP_DIR/etc/pam.d/system-password << "EOF"
# Begin /etc/pam.d/system-password

# check new passwords for strength (man pam_pwquality)
password  required    pam_pwquality.so   authtok_type=UNIX retry=1 difok=1 \
                                         minlen=8 dcredit=0 ucredit=0 \
                                         lcredit=0 ocredit=0 minclass=1 \
                                         maxrepeat=0 maxsequence=0 \
                                         maxclassrepeat=0 gecoscheck=0 \
                                         dictcheck=1 usercheck=1 \
                                         enforcing=1 badwords="" \
                                         dictpath=/usr/lib/cracklib/pw_dict

# use yescrypt hash for encryption, use shadow, and try to use any
# previously defined authentication token (chosen password) set by any
# prior module.
password  required    pam_unix.so        yescrypt shadow try_first_pass

# End /etc/pam.d/system-password
EOF
}
