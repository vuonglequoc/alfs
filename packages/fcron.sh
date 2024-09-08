#!/bin/bash

KPKG_SRC_FILE=fcron-3.2.1.src.tar.gz
KPKG_SRC_FOLDER=fcron-3.2.1

k_pre_configure() {
cat >> /etc/syslog.conf << "EOF"
# Begin fcron addition to /etc/syslog.conf

cron.* -/var/log/cron.log

# End fcron addition
EOF

/etc/rc.d/init.d/sysklogd reload

groupadd -g 22 fcron &&
useradd -d /dev/null -c "Fcron User" -g fcron -s /bin/false -u 22 fcron

find doc -type f -exec sed -i 's:/usr/local::g' {} \;
}

k_configure() {
  ./configure --prefix=/usr          \
              --sysconfdir=/etc      \
              --localstatedir=/var   \
              --without-sendmail     \
              --with-boot-install=no \
              --with-systemdsystemunitdir=no
}

k_check() {
  :
}

k_pre_install() {
mkdir $KPKG_TMP_DIR/etc/pam.d
make DESTDIR=$KPKG_TMP_DIR install

cat > $KPKG_TMP_DIR/usr/bin/run-parts << "EOF"
#!/bin/sh
# run-parts:  Runs all the scripts found in a directory.
# from Slackware, by Patrick J. Volkerding with ideas borrowed
# from the Red Hat and Debian versions of this utility.

# keep going when something fails
set +e

if [ $# -lt 1 ]; then
  echo "Usage: run-parts <directory>"
  exit 1
fi

if [ ! -d $1 ]; then
  echo "Not a directory: $1"
  echo "Usage: run-parts <directory>"
  exit 1
fi

# There are several types of files that we would like to
# ignore automatically, as they are likely to be backups
# of other scripts:
IGNORE_SUFFIXES="~ ^ , .bak .new .rpmsave .rpmorig .rpmnew .swp"

# Main loop:
for SCRIPT in $1/* ; do
  # If this is not a regular file, skip it:
  if [ ! -f $SCRIPT ]; then
    continue
  fi
  # Determine if this file should be skipped by suffix:
  SKIP=false
  for SUFFIX in $IGNORE_SUFFIXES ; do
    if [ ! "$(basename $SCRIPT $SUFFIX)" = "$(basename $SCRIPT)" ]; then
      SKIP=true
      break
    fi
  done
  if [ "$SKIP" = "true" ]; then
    continue
  fi
  # If we've made it this far, then run the script if it's executable:
  if [ -x $SCRIPT ]; then
    $SCRIPT || echo "$SCRIPT failed."
  fi
done

exit 0
EOF

chmod -v 755 $KPKG_TMP_DIR/usr/bin/run-parts

install -vdm754 $KPKG_TMP_DIR/etc/cron.{hourly,daily,weekly,monthly}

cat > $KPKG_TMP_DIR/var/spool/fcron/systab.orig << "EOF"
&bootrun 01 * * * * root run-parts /etc/cron.hourly
&bootrun 02 4 * * * root run-parts /etc/cron.daily
&bootrun 22 4 * * 0 root run-parts /etc/cron.weekly
&bootrun 42 4 1 * * root run-parts /etc/cron.monthly
EOF

# start the FCron at system boot
cd $KPKG_ROOT/sources
tar -xf blfs-bootscripts-20240416.tar.xz
cd blfs-bootscripts-20240416
make DESTDIR=$KPKG_TMP_DIR install-fcron
cd $KPKG_ROOT/sources
rm -r blfs-bootscripts-20240416
}

k_post_install() {
  /etc/rc.d/init.d/fcron start
  fcrontab -z -u systab
}
