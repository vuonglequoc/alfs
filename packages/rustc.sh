#!/bin/bash

KPKG_SRC_FILE=rustc-1.79.0-src.tar.xz
KPKG_SRC_FOLDER=rustc-1.79.0-src

k_pre_configure() {
  mkdir -pv /opt/rustc-1.79.0
  ln -svfn rustc-1.79.0 /opt/rustc

  # Same for 1.79.0
  patch -Np1 -i ../rustc-1.76.0-testsuite_fix-1.patch
}

k_configure() {
cat << EOF > config.toml
# see config.toml.example for more possible options
# See the 8.4 book for an old example using shipped LLVM
# e.g. if not installing clang, or using a version before 13.0

# Tell x.py the editors have reviewed the content of this file
# and updated it to follow the major changes of the building system,
# so x.py will not warn us to do such a review.
change-id = 118703

[llvm]
# by default, rust will build for a myriad of architectures
targets = "X86"

# When using system llvm prefer shared libraries
link-shared = true

[build]
# omit docs to save time and space (default is to build them)
docs = false

# install extended tools: cargo, clippy, etc
extended = true

# Do not query new versions of dependencies online.
locked-deps = true

# Specify which extended tools (those from the default install).
tools = ["cargo", "clippy", "rustdoc", "rustfmt"]

# Use the source code shipped in the tarball for the dependencies.
# The combination of this and the "locked-deps" entry avoids downloading
# many crates from Internet, and makes the Rustc build more stable.
vendor = true

[install]
prefix = "/opt/rustc-1.79.0"
docdir = "share/doc/rustc-1.79.0"

[rust]
channel = "stable"
description = "for BLFS 12.1"

# BLFS used to not install the FileCheck executable from llvm,
# so disabled codegen tests.  The assembly tests rely on FileCheck
# and cannot easily be disabled, so those will anyway fail if
# FileCheck has not been installed.
#codegen-tests = false

# Enable the same optimizations as the official upstream build.
lto = "thin"
codegen-units = 1

[target.x86_64-unknown-linux-gnu]
# NB the output of llvm-config (i.e. help options) may be
# dumped to the screen when config.toml is parsed.
llvm-config = "/usr/bin/llvm-config"

[target.i686-unknown-linux-gnu]
# NB the output of llvm-config (i.e. help options) may be
# dumped to the screen when config.toml is parsed.
llvm-config = "/usr/bin/llvm-config"
EOF
}

k_build() {
  { [ ! -e /usr/include/libssh2.h ] ||
    export LIBSSH2_SYS_USE_PKG_CONFIG=1; }
  python3 x.py build
}

k_check() {
  SSL_CERT_DIR=/etc/ssl/certs \
  python3 x.py test --verbose --no-fail-fast | tee rustc-testlog

  grep '^test result:' rustc-testlog |
    awk '{sum1 += $4; sum2 += $6} END { print sum1 " passed; " sum2 " failed" }'
}

k_pre_install() {
# Install to /opt/rustc-1.79.0
{ [ ! -e /usr/include/libssh2.h ] ||
  export LIBSSH2_SYS_USE_PKG_CONFIG=1; }
python3 x.py install

mkdir -p $KPKG_TMP_DIR/opt/
mv /opt/rustc-1.79.0 $KPKG_TMP_DIR/opt/
ln -sfv rustc-1.79.0 \
        $KPKG_TMP_DIR/opt/rustc

find $KPKG_TMP_DIR/opt/rustc-1.79.0 -name "*.old" -delete

install -vdm755 $KPKG_TMP_DIR/usr/share/zsh/site-functions
ln -sfv /opt/rustc/share/zsh/site-functions/_cargo \
        $KPKG_TMP_DIR/usr/share/zsh/site-functions

unset LIBSSH2_SYS_USE_PKG_CONFIG

mkdir -p $KPKG_TMP_DIR/etc/profile.d
cat > $KPKG_TMP_DIR/etc/profile.d/rustc.sh << "EOF"
# Begin /etc/profile.d/rustc.sh

pathprepend /opt/rustc/bin           PATH

# Include /opt/rustc/man in the MANPATH variable to access manual pages
pathappend  /opt/rustc/share/man     MANPATH

# End /etc/profile.d/rustc.sh
EOF

# Source rustc.sh in non-root user
# source /etc/profile.d/rustc.sh
}
