#!/bin/bash

KPKG_SRC_FILE=glibc-2.40.tar.xz
KPKG_SRC_FOLDER=glibc-2.40

k_pre_configure() {
  patch -Np1 -i ../glibc-2.40-fhs-1.patch

  mkdir -v build
  cd       build

  echo "rootsbindir=/usr/sbin" > configparms
}

k_configure() {
  ../configure --prefix=/usr                  \
              --disable-werror                \
              --enable-kernel=4.19            \
              --enable-stack-protector=strong \
              --disable-nscd                  \
              libc_cv_slibdir=/usr/lib
}

k_pre_install() {
touch /etc/ld.so.conf

sed '/test-installation/s@$(PERL)@echo not running@' -i ../Makefile

make DESTDIR=$KPKG_TMP_DIR install

sed '/RTLDLIST=/s@/usr@@g' -i $KPKG_TMP_DIR/usr/bin/ldd

# install all the locales listed in the glibc-2.40/localedata/SUPPORTED file
mkdir -pv $KPKG_TMP_DIR/usr/lib/locale
make DESTDIR=$KPKG_TMP_DIR localedata/install-locales

# create and install locales not listed in the glibc-2.40/localedata/SUPPORTED file
localedef -i C -f UTF-8 C.UTF-8 $KPKG_TMP_DIR/usr/lib/locale/locale-archive
localedef -i ja_JP -f SHIFT_JIS ja_JP.SJIS $KPKG_TMP_DIR/usr/lib/locale/locale-archive 2> /dev/null || true

# 8.5.2.1. Adding nsswitch.conf

cat > $KPKG_TMP_DIR/etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF

# 8.5.2.2. Adding Time Zone Data

tar -xf ../../tzdata2024a.tar.gz

ZONEINFO=$KPKG_TMP_DIR/usr/share/zoneinfo
mkdir -pv $ZONEINFO/{posix,right}

for tz in etcetera southamerica northamerica europe africa antarctica  \
          asia australasia backward; do
    zic -L /dev/null   -d $ZONEINFO       ${tz}
    zic -L /dev/null   -d $ZONEINFO/posix ${tz}
    zic -L leapseconds -d $ZONEINFO/right ${tz}
done

cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
zic -d $ZONEINFO -p America/New_York
unset ZONEINFO

# tzselect
# ln -sfv /usr/share/zoneinfo/<xxx> $KPKG_TMP_DIR/etc/localtime

# 8.5.2.3. Configuring the Dynamic Loader

cat > $KPKG_TMP_DIR/etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

EOF

cat >> $KPKG_TMP_DIR/etc/ld.so.conf << "EOF"
# Add an include directory
include /etc/ld.so.conf.d/*.conf

EOF

mkdir -pv $KPKG_TMP_DIR/etc/ld.so.conf.d
}
