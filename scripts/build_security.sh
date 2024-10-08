#!/bin/bash

# Security 
# three different types of security: access, prevention and detection.
# enhance login by setting policies with PAM modules
# Access via networks can also be secured by policies set by iptables, commonly referred to as a firewall.
# For applications that don't offer the best security, you can use the Stunnel package to wrap an application daemon inside an SSL tunnel.
# Prevention of breaches, like a trojan, are assisted by applications like GnuPG, specifically the ability to confirm signed packages, which recognizes modifications of the tarball after the packager creates it.
# touch on detection with a package that stores "signatures" of critical files (defined by the administrator) and then regenerates those "signatures" and compares for files that have been changed.

# Already installed but may need rebuild
#       MIT Kerberos V5-1.21.2
#     libtirpc
#   Linux-PAM-1.6.0
# libcap with PAM -> need rebuild
#   Linux-PAM-1.6.0
#   CrackLib-2.9.11
#   libpwquality-1.4.5
# Shadow -> need rebuild
#   Linux-PAM-1.6.0
#   MIT Kerberos V5-1.21.2
#       Linux-PAM-1.6.0
#       MIT Kerberos V5-1.21.2
#         UnZip
#       SQLite
#     Cyrus SASL-2.1.28
#   OpenLDAP-2.6.7
# Sudo-1.9.15p5 -> need rebuild
# OpenSSH-9.8p1



# Linux-PAM-1.6.0

# iptables-1.8.10
# Setting Up a Network Firewall

# stunnel-5.72

#     NSPR-4.35
#     SQLite
#   nss
#         libgpg-error-1.47
#       libgcrypt-1.10.3
#         ICU-74.2
#       libxml2
#         libxml2
#         sgml-common-0.6.3
#         UnZip
#       docbook-xml-4.5
#         libxml2
#         Zip-3.0
#       docbook-xsl-nons-1.79.2
#     libxslt-1.1.39
#     libtasn1-4.19.0
#   p11-kit-0.25.3
# make-ca-1.13

#     Nettle-3.9.1
#     make-ca-1.13
#     libtasn1-4.19.0
#     libunistring-1.1
#     Unbound
#     p11-kit-0.25.3
#   GnuTLS
#     libgpg-error-1.47
#   libassuan-2.5.6
#   libgcrypt-1.10.3
#     libgpg-error-1.47
#   libksba-1.6.5
#   npth-1.6
#   OpenLDAP-2.6.7
#     libgpg-error-1.47
#     libassuan-2.5.6
#   pinentry-1.2.1
#       libidn2-2.3.7
#     libpsl-0.21.5
#     make-ca-1.13
#     GnuTLS
#     OpenLDAP-2.6.7
#   cURL
#         cURL
#         libarchive-3.7.2
#         libuv-1.48.0,
#       CMake
#       NASM-2.16.01
#         Python
#         cython
#       yasm-1.3.0
#     libjpeg-turbo
#     libpng
#   ImageMagick
#   libusb-1.0.27
#   SQLite
# GnuPG-2.4.4

if [ -z "$NONROOT_USER" ]
  then echo "Please check environment variable NONROOT_USER"
  exit
fi

source /alfs/kpkg/kpkg.sh

kpkg_install krb5
kpkg_install libtirpc
kpkg_install linux-pam

kpkg_install cracklib
kpkg_install python/libpwquality

# rebuild libcap, shadow, sudo
kpkg_install libcap_pam
kpkg_install shadow_pam
kpkg_install unzip
kpkg_install sqlite
# rebuild python with sqlite for building firefox later
kpkg_install python
kpkg_install cyrus-sasl
kpkg_install openldap
kpkg_install sudo_pam

# Setting Up a Network Firewall
kpkg_install iptables
# Modify iptables for other rules
# /etc/rc.d/rc.iptables
# Update Linux Kernel for iptables
cd /sources/linux-6.10.7
cp /alfs/defaults/boot/config-6.10.7.base.uefi.iptables .config
make
make modules_install
cp -v arch/x86_64/boot/bzImage /boot/vmlinuz-$(uname -r)-lfs-12.2
cp -v System.map /boot/System.map-$(uname -r)-lfs-12.2
cp -v .config /boot/config-$(uname -r)-lfs-12.2

kpkg_install stunnel
# /etc/stunnel/stunnel.conf
# add the service(s) you wish to encrypt to the configuration file. The format is as follows:
# [<service>]
# accept  = <hostname:portnumber>
# connect = <hostname:portnumber>

kpkg_install nspr
kpkg_install nss
kpkg_install libgpg-error
kpkg_install libgcrypt
kpkg_install icu
kpkg_install libxml2
kpkg_install sgml-common
kpkg_install docbook-xml
kpkg_install zip
kpkg_install docbook-xsl-nons
kpkg_install libxslt
kpkg_install libtasn1
kpkg_install p11-kit
kpkg_install make-ca

# Enable Certificate Check for Wget
sed -i "s/check_certificate = off/check_certificate = on/g" /home/$NONROOT_USER/.wgetrc
sed -i "s/check_certificate = off/check_certificate = on/g" /root/.wgetrc

kpkg_install nettle
kpkg_install libunistring
kpkg_install unbound
kpkg_install gnutls
kpkg_install libassuan
kpkg_install libksba
kpkg_install npth
kpkg_install pinentry
kpkg_install libidn2
kpkg_install libpsl
kpkg_install curl
kpkg_install libarchive
kpkg_install libuv
kpkg_install cmake
kpkg_install nasm
kpkg_install python/Cython
kpkg_install yasm
kpkg_install libjpeg-turbo
kpkg_install libpng
kpkg_install imagemagick
kpkg_install libusb
# No need update Linux Kernel for usb because it's existed by default
kpkg_install gnupg
