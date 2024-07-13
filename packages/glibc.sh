#!/bin/bash

SRC_FILE=glibc-2.39.tar.xz
SRC_FOLDER=glibc-2.39

k_pre_configure() {
  patch -Np1 -i ../glibc-2.39-fhs-1.patch

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

k_install() {
  touch /etc/ld.so.conf

  sed '/test-installation/s@$(PERL)@echo not running@' -i ../Makefile

  make install
}

k_post_install() {
sed '/RTLDLIST=/s@/usr@@g' -i /usr/bin/ldd

mkdir -pv /usr/lib/locale

make localedata/install-locales

localedef -i C -f UTF-8 C.UTF-8
localedef -i ja_JP -f SHIFT_JIS ja_JP.SJIS 2> /dev/null || true

# 8.5.2.1. Adding nsswitch.conf

cat > /etc/nsswitch.conf << "EOF"
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

ZONEINFO=/usr/share/zoneinfo
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
# ln -sfv /usr/share/zoneinfo/<xxx> /etc/localtime

# 8.5.2.3. Configuring the Dynamic Loader

cat > /etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

EOF

cat >> /etc/ld.so.conf << "EOF"
# Add an include directory
include /etc/ld.so.conf.d/*.conf

EOF

mkdir -pv /etc/ld.so.conf.d
}
