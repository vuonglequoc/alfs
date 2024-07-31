#!/bin/bash

source /alfs/kpkg/kpkg.sh

# 9.2.1. Installation of LFS-Bootscripts
kpkg_install /alfs packages lfs-bootscripts

# 9.4.1.2. Creating Custom Udev Rules
bash /usr/lib/udev/init-net-rules.sh

cat /etc/udev/rules.d/70-persistent-net.rules

# sed -e '/^AlternativeNamesPolicy/s/=.*$/=/'  \
#     -i /usr/lib/udev/network/99-default.link \
#      > /etc/udev/network/99-default.link

# 9.4.2. CD-ROM Symlinks
udevadm test /sys/block/hdd

# sed -e 's/"write_cd_rules"/"write_cd_rules mode"/' \
#     -i /etc/udev/rules.d/83-cdrom-symlinks.rules

# 9.4.3. Dealing with Duplicate Devices


# 9.5.1. Creating Network Interface Configuration Files
# Need to check the interface name: eth0, eno1, enp0s3, ...
cd /etc/sysconfig/
cat > ifconfig.eth0 << "EOF"
ONBOOT=yes
IFACE=eth0
SERVICE=ipv4-static
IP=192.168.1.2
GATEWAY=192.168.1.1
PREFIX=24
BROADCAST=192.168.1.255
EOF

# 9.5.2. Creating the /etc/resolv.conf File
cat > /etc/resolv.conf << "EOF"
# Begin /etc/resolv.conf

nameserver 8.8.8.8
nameserver 8.8.4.4

# End /etc/resolv.conf
EOF

# 9.5.3. Configuring the system hostname
echo "LFS" > /etc/hostname

# 9.5.4. Customizing the /etc/hosts File
cat > /etc/hosts << "EOF"
# Begin /etc/hosts

127.0.0.1 localhost.localdomain localhost
127.0.1.1 LFS
192.168.1.10 LFS
::1       localhost ip6-localhost ip6-loopback
ff02::1   ip6-allnodes
ff02::2   ip6-allrouters

# End /etc/hosts
EOF

# 9.6.2. Configuring Sysvinit
cat > /etc/inittab << "EOF"
# Begin /etc/inittab

id:3:initdefault:

si::sysinit:/etc/rc.d/init.d/rc S

l0:0:wait:/etc/rc.d/init.d/rc 0
l1:S1:wait:/etc/rc.d/init.d/rc 1
l2:2:wait:/etc/rc.d/init.d/rc 2
l3:3:wait:/etc/rc.d/init.d/rc 3
l4:4:wait:/etc/rc.d/init.d/rc 4
l5:5:wait:/etc/rc.d/init.d/rc 5
l6:6:wait:/etc/rc.d/init.d/rc 6

ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

su:S06:once:/sbin/sulogin
s1:1:respawn:/sbin/sulogin

1:2345:respawn:/sbin/agetty --noclear tty1 9600
2:2345:respawn:/sbin/agetty tty2 9600
3:2345:respawn:/sbin/agetty tty3 9600
4:2345:respawn:/sbin/agetty tty4 9600
5:2345:respawn:/sbin/agetty tty5 9600
6:2345:respawn:/sbin/agetty tty6 9600

# End /etc/inittab
EOF

# 9.6.4. Configuring the System Clock
cat > /etc/sysconfig/clock << "EOF"
# Begin /etc/sysconfig/clock

UTC=1

# Set this to any options you might need to give to hwclock,
# such as machine hardware clock type for Alphas.
CLOCKPARAMS=

# End /etc/sysconfig/clock
EOF

# 9.6.5. Configuring the Linux Console
cat > /etc/sysconfig/console << "EOF"
# Begin /etc/sysconfig/console

UNICODE="1"
FONT="Lat2-Terminus16"

# End /etc/sysconfig/console
EOF

# 9.7. Configuring the System Locale

locale -a

LC_ALL=ja_JP locale language
# -> Japanese
LC_ALL=ja_JP locale charmap
# -> EUC-JP
LC_ALL=ja_JP locale int_curr_symbol
# -> JPY
LC_ALL=ja_JP locale int_prefix
# -> 81

cat > /etc/profile << "EOF"
# Begin /etc/profile

for i in $(locale); do
 unset ${i%=*}
done

if [[ "$TERM" = linux ]]; then
 export LANG=C.UTF-8
else
 export LANG=en_US.UTF-8
fi

# End /etc/profile
EOF

# 9.8. Creating the /etc/inputrc File
cat > /etc/inputrc << "EOF"
# Begin /etc/inputrc

# Allow the command prompt to wrap to the next line
set horizontal-scroll-mode Off

# Enable 8-bit input
set meta-flag On
set input-meta On

# Turns off 8th bit stripping
set convert-meta Off

# Keep the 8th bit for display
set output-meta On

# none, visible or audible
set bell-style none

# All of the following map the escape sequence of the value
# contained in the 1st argument to the readline specific functions
"\eOd": backward-word
"\eOc": forward-word

# for linux console
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\e[5~": beginning-of-history
"\e[6~": end-of-history
"\e[3~": delete-char
"\e[2~": quoted-insert

# for xterm
"\eOH": beginning-of-line
"\eOF": end-of-line

# for Konsole
"\e[H": beginning-of-line
"\e[F": end-of-line

# End /etc/inputrc
EOF

# 9.9. Creating the /etc/shells File
cat > /etc/shells << "EOF"
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF
