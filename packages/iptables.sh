#!/bin/bash

KPKG_SRC_FILE=iptables-1.8.10.tar.xz
KPKG_SRC_FOLDER=iptables-1.8.10

k_configure() {
  ./configure --prefix=/usr      \
              --disable-nftables \
              --enable-libipq
}

k_check() {
  :
}

k_post_install() {
cat > /etc/rc.d/rc.iptables << "EOF"
#!/bin/sh

# Begin rc.iptables

echo
echo "You're using the example configuration for a setup of a firewall"
echo "from Beyond Linux From Scratch."
echo "This example is far from being complete, it is only meant"
echo "to be a reference."
echo "Firewall security is a complex issue, that exceeds the scope"
echo "of the configuration rules below."
echo "You can find additional information"
echo "about firewalls in Chapter 4 of the BLFS book."
echo "https://www.linuxfromscratch.org/blfs"
echo

LOIF=lo
WANIF=eth0
#WANIF=enp0s3
SSHPORT=22
HTTPPORT=80
HTTPSPORT=443
NSPORT=53

# Insert iptables modules (not needed if built into the kernel).

modprobe nf_conntrack
modprobe nf_conntrack_ftp
modprobe xt_conntrack
modprobe xt_LOG
modprobe xt_state

# Enable broadcast echo Protection
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts

# Disable Source Routed Packets
echo 0 > /proc/sys/net/ipv4/conf/all/accept_source_route

# Enable TCP SYN Cookie Protection
echo 1 > /proc/sys/net/ipv4/tcp_syncookies

# Disable ICMP Redirect Acceptance
echo 0 > /proc/sys/net/ipv4/conf/all/accept_redirects

# Don't send Redirect Messages
echo 0 > /proc/sys/net/ipv4/conf/default/send_redirects

# Drop Spoofed Packets coming in on an interface where responses
# would result in the reply going out a different interface.
echo 1 > /proc/sys/net/ipv4/conf/default/rp_filter

# Log packets with impossible addresses.
echo 1 > /proc/sys/net/ipv4/conf/all/log_martians

# Be verbose on dynamic ip-addresses  (not needed in case of static IP)
echo 2 > /proc/sys/net/ipv4/ip_dynaddr

# Disable Explicit Congestion Notification
# Too many routers are still ignorant
echo 0 > /proc/sys/net/ipv4/tcp_ecn

# Set a known state
iptables -P INPUT   DROP
iptables -P FORWARD DROP
iptables -P OUTPUT  DROP

# These lines are here in case rules are already in place and the
# script is ever rerun on the fly. We want to remove all rules and
# pre-existing user defined chains before we implement new rules.
iptables -F
iptables -X
iptables -Z

iptables -t nat -F

# Allow local connections
iptables -A INPUT  -i $LOIF -j ACCEPT
iptables -A OUTPUT -o $LOIF -j ACCEPT

# Allow forwarding if the initiated on the intranet
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD ! -i $WANIF -m conntrack --ctstate NEW     -j ACCEPT

# Do masquerading
iptables -t nat -A POSTROUTING -o $WANIF -j MASQUERADE

# Log everything for debugging
# (last of all rules, but before policy rules)
iptables -A INPUT   -j LOG --log-prefix "FIREWALL:INPUT "
iptables -A FORWARD -j LOG --log-prefix "FIREWALL:FORWARD "
iptables -A OUTPUT  -j LOG --log-prefix "FIREWALL:OUTPUT "

# Enable IP Forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# Custom rules

# log and drop invalid packets
#iptables -I INPUT 0 -p tcp -m conntrack --ctstate INVALID \
#  -j LOG --log-prefix "FIREWALL:INVALID "
#iptables -I INPUT 1 -p tcp -m conntrack --ctstate INVALID -j DROP

# Anything coming from the outside should not have a private address, this is a common attack called IP-spoofing
#iptables -A INPUT -i $WANIF -s 10.0.0.0/8     -j DROP
#iptables -A INPUT -i $WANIF -s 172.16.0.0/12  -j DROP
#iptables -A INPUT -i $WANIF -s 192.168.0.0/16 -j DROP


#iptables -A INPUT -i $WANIF -s 0.0.0.0/8      -j DROP
#iptables -A INPUT -i $WANIF -s 127.0.0.0/8    -j DROP
# multicast and experimental
#iptables -A INPUT -i $WANIF -s 224.0.0.0/3    -j DROP
# Link Local Networks
#iptables -A INPUT -i $WANIF -s 169.254.0.0/16 -j DROP
# IANA defined test network
#iptables -A INPUT -i $WANIF -s 192.0.2.0/24   -j DROP

# SSH
iptables -A INPUT -p tcp -m tcp --dport $SSHPORT -j ACCEPT
iptables -A OUTPUT -p tcp --sport $SSHPORT -m state --state ESTABLISHED -j ACCEPT

# name server
iptables -A INPUT  -p udp --sport $NSPORT -j ACCEPT
iptables -A OUTPUT -p udp --dport $NSPORT -j ACCEPT

# ping us
iptables -A INPUT  -p icmp -m icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp -m icmp --icmp-type echo-reply   -j ACCEPT

# ping outside
iptables -A OUTPUT -p icmp -m icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT  -p icmp -m icmp --icmp-type echo-reply   -j ACCEPT

# HTTP/HTTPS
iptables -A OUTPUT -p tcp -m tcp --dport $HTTPPORT -j ACCEPT
iptables -A INPUT  -p tcp --sport $HTTPPORT -m conntrack --ctstate ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport $HTTPSPORT -j ACCEPT
iptables -A INPUT  -p tcp --sport $HTTPSPORT -m conntrack --ctstate ESTABLISHED -j ACCEPT
EOF
chmod 700 /etc/rc.d/rc.iptables

# start the iptables at system boot
cd $KPKG_ROOT/sources
tar -xf blfs-bootscripts-20240416.tar.xz
cd blfs-bootscripts-20240416
make install-iptables
cd $KPKG_ROOT/sources
rm -r blfs-bootscripts-20240416
}

k_pre_record() {
  cd $KPKG_ROOT/sources/$KPKG_SRC_FOLDER
  make DESTDIR=$KPKG_TMP_DIR install

  cp /etc/rc.d/rc.iptables $KPKG_TMP_DIR/etc/rc.d/rc.iptables

  cd $KPKG_ROOT/sources
  tar -xf blfs-bootscripts-20240416.tar.xz
  cd blfs-bootscripts-20240416
  make DESTDIR=$KPKG_TMP_DIR install-iptables
  cd $KPKG_ROOT/sources
  rm -r blfs-bootscripts-20240416
}
