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
#     libtirpc-1.3.4
#   Linux-PAM-1.6.0
# libcap-2.69 with PAM -> need rebuild
#   Linux-PAM-1.6.0
#   CrackLib-2.9.11
#   libpwquality-1.4.5
# Shadow-4.14.5 -> need rebuild
#   Linux-PAM-1.6.0
#   MIT Kerberos V5-1.21.2
#       Linux-PAM-1.6.0
#       MIT Kerberos V5-1.21.2
#         UnZip-6.0
#       SQLite-3.45.1
#     Cyrus SASL-2.1.28
#   OpenLDAP-2.6.7
# Sudo-1.9.15p5 -> need rebuild
# OpenSSH-9.8p1



# Linux-PAM-1.6.0

# iptables-1.8.10
# Setting Up a Network Firewall

# stunnel-5.72

#     NSPR-4.35
#     SQLite-3.45.1
#   nss-3.98
#         libgpg-error-1.47
#       libgcrypt-1.10.3
#         ICU-74.2
#       libxml2-2.12.5
#         libxml2-2.12.5
#         sgml-common-0.6.3
#         UnZip-6.0
#       docbook-xml-4.5
#         libxml2-2.12.5
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
#     Unbound-1.19.1
#     p11-kit-0.25.3
#   GnuTLS-3.8.3
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
#     GnuTLS-3.8.3
#     OpenLDAP-2.6.7
#   cURL-8.6.0
#         cURL-8.6.0
#         libarchive-3.7.2
#         libuv-1.48.0,
#       CMake-3.28.3
#       NASM-2.16.01
#         Python
#         cython-0.29.36
#       yasm-1.3.0
#     libjpeg-turbo
#     libpng
#   ImageMagick-7.1.1-28
#   libusb-1.0.27
#   SQLite-3.45.1
# GnuPG-2.4.4

source /alfs/kpkg/kpkg.sh

kpkg_install /alfs packages krb5
kpkg_install /alfs packages libtirpc
kpkg_install /alfs packages linux-pam

kpkg_install /alfs packages cracklib
kpkg_install /alfs packages python/libpwquality

# rebuild libcap, shadow, sudo
kpkg_install /alfs packages libcap_pam
kpkg_install /alfs packages shadow_pam
kpkg_install /alfs packages unzip
kpkg_install /alfs packages sqlite
# rebuild python with sqlite for building firefox later
kpkg_install /alfs packages python
kpkg_install /alfs packages cyrus-sasl
kpkg_install /alfs packages openldap
kpkg_install /alfs packages sudo_pam

# Setting Up a Network Firewall
kpkg_install /alfs packages iptables
# Modify iptables for other rules
# /etc/rc.d/rc.iptables
# Update Linux Kernel for iptables
cd /sources/linux-6.7.4
cp /alfs/defaults/boot/config-6.7.4.base.uefi.iptables .config
make
make modules_install
cp -v arch/x86_64/boot/bzImage /boot/vmlinuz-$(uname -r)-lfs-12.1
cp -v System.map /boot/System.map-$(uname -r)-lfs-12.1
cp -v .config /boot/config-$(uname -r)-lfs-12.1

kpkg_install /alfs packages stunnel
# /etc/stunnel/stunnel.conf
# add the service(s) you wish to encrypt to the configuration file. The format is as follows:
# [<service>]
# accept  = <hostname:portnumber>
# connect = <hostname:portnumber>

kpkg_install /alfs packages nspr
kpkg_install /alfs packages nss
kpkg_install /alfs packages libgpg-error
kpkg_install /alfs packages libgcrypt
kpkg_install /alfs packages icu
kpkg_install /alfs packages libxml2
kpkg_install /alfs packages sgml-common
kpkg_install /alfs packages docbook-xml
kpkg_install /alfs packages zip
kpkg_install /alfs packages docbook-xsl-nons
kpkg_install /alfs packages libxslt
kpkg_install /alfs packages libtasn1
kpkg_install /alfs packages p11-kit
kpkg_install /alfs packages make-ca

# Enable Certificate Check for Wget
sed -i "s/check_certificate = off/check_certificate = on/g" /home/user/.wgetrc

kpkg_install /alfs packages nettle
kpkg_install /alfs packages libunistring
kpkg_install /alfs packages unbound
kpkg_install /alfs packages gnutls
kpkg_install /alfs packages libassuan
kpkg_install /alfs packages libksba
kpkg_install /alfs packages npth
kpkg_install /alfs packages pinentry
kpkg_install /alfs packages libidn2
kpkg_install /alfs packages libpsl
kpkg_install /alfs packages curl
kpkg_install /alfs packages libarchive
kpkg_install /alfs packages libuv
kpkg_install /alfs packages cmake
kpkg_install /alfs packages nasm
kpkg_install /alfs packages python/Cython
kpkg_install /alfs packages yasm
kpkg_install /alfs packages libjpeg-turbo
kpkg_install /alfs packages libpng
kpkg_install /alfs packages imagemagick
kpkg_install /alfs packages libusb
# No need update Linux Kernel for usb because it's existed by default
kpkg_install /alfs packages gnupg
