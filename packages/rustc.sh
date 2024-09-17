#!/bin/bash

KPKG_SRC_FILE=rustc-1.80.1-src.tar.xz
KPKG_SRC_FOLDER=rustc-1.80.1-src

k_configure() {
cat > config.toml << EOF
# see config.toml.example for more possible options
# See the 8.4 book for an old example using shipped LLVM
# e.g. if not installing clang, or using a version before 13.0

# Tell x.py the editors have reviewed the content of this file
# and updated it to follow the major changes of the building system,
# so x.py will not warn us to do such a review.
change-id = 125535

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
EOF

# Custom prefix
echo "prefix = \"$KPKG_TMP_DIR/opt/rustc-1.80.1\"" >> config.toml

cat >> config.toml << EOF
docdir = "share/doc/rustc-1.80.1"

[rust]
channel = "stable"
description = "for BLFS 12.2"

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
    export LIBSSH2_SYS_USE_PKG_CONFIG=1; }    &&
  { [ ! -e /usr/include/sqlite3.h ] ||
    export LIBSQLITE3_SYS_USE_PKG_CONFIG=1; } &&
  python3 x.py build
}

k_check() {
  SSL_CERT_DIR=/etc/ssl/certs \
  python3 x.py test --verbose --no-fail-fast --keep-stage-std=1 | \
      tee rustc-testlog

  grep '^test result:' rustc-testlog |
    awk '{sum1 += $4; sum2 += $6} END { print sum1 " passed; " sum2 " failed" }'
}

k_pre_install() {
{ [ ! -e /usr/include/libssh2.h ] ||
  export LIBSSH2_SYS_USE_PKG_CONFIG=1; }    &&
{ [ ! -e /usr/include/sqlite3.h ] ||
  export LIBSQLITE3_SYS_USE_PKG_CONFIG=1; } &&
python3 x.py install rustc std

ln -sfv rustc-1.80.1 \
        $KPKG_TMP_DIR/opt/rustc

install -vm755 \
  build/host/stage1-tools/*/*/{cargo{,-clippy,-fmt},clippy-driver,rustfmt} \
  $KPKG_TMP_DIR/opt/rustc-1.80.1/bin &&
install -vDm644 \
  src/tools/cargo/src/etc/_cargo \
  $KPKG_TMP_DIR/opt/rustc-1.80.1/share/zsh/site-functions/_cargo &&
install -vm644 src/tools/cargo/src/etc/man/* \
  $KPKG_TMP_DIR/opt/rustc-1.80.1/share/man/man1

# fix the installation of documentation and symlink a Zsh completion file into the correct location
rm -fv $KPKG_TMP_DIR/opt/rustc-1.80.1/share/doc/rustc-1.80.1/*.old
install -vm644 README.md                                            \
               $KPKG_TMP_DIR/opt/rustc-1.80.1/share/doc/rustc-1.80.1

install -vdm755 $KPKG_TMP_DIR/usr/share/zsh/site-functions
ln -sfv /opt/rustc/share/zsh/site-functions/_cargo \
        $KPKG_TMP_DIR/usr/share/zsh/site-functions

unset LIB{SSH2,SQLITE3}_SYS_USE_PKG_CONFIG

# Configuring Rust
mkdir -pv $KPKG_TMP_DIR/etc/profile.d
cat > $KPKG_TMP_DIR/etc/profile.d/rustc.sh << "EOF"
# Begin /etc/profile.d/rustc.sh

pathprepend /opt/rustc/bin           PATH

# End /etc/profile.d/rustc.sh
EOF
}

k_post_install() {
  # Source rustc.sh in non-root user
  # source /etc/profile.d/rustc.sh
  :
}
