#!/bin/bash

KPKG_SRC_FILE=llvm-18.1.8.src.tar.xz
KPKG_SRC_FOLDER=llvm-18.1.8.src

k_pre_configure() {
  tar -xf ../llvm-cmake-18.src.tar.xz
  tar -xf ../llvm-third-party-18.src.tar.xz
  sed '/LLVM_COMMON_CMAKE_UTILS/s@../cmake@llvm-cmake-18.src@'          \
      -i CMakeLists.txt
  sed '/LLVM_THIRD_PARTY_DIR/s@../third-party@llvm-third-party-18.src@' \
      -i cmake/modules/HandleLLVMOptions.cmake

  tar -xf ../clang-18.1.8.src.tar.xz -C tools
  mv tools/clang-18.1.8.src tools/clang

  tar -xf ../compiler-rt-18.1.8.src.tar.xz -C projects
  mv projects/compiler-rt-18.1.8.src projects/compiler-rt

  grep -rl '#!.*python' | xargs sed -i '1s/python$/python3/'

  sed 's/utility/tool/' -i utils/FileCheck/CMakeLists.txt

  mkdir -v build
  cd       build
}

k_configure() {
  CC=gcc CXX=g++                               \
  cmake -D CMAKE_INSTALL_PREFIX=/usr           \
        -D CMAKE_SKIP_INSTALL_RPATH=ON         \
        -D LLVM_ENABLE_FFI=ON                  \
        -D CMAKE_BUILD_TYPE=Release            \
        -D LLVM_BUILD_LLVM_DYLIB=ON            \
        -D LLVM_LINK_LLVM_DYLIB=ON             \
        -D LLVM_ENABLE_RTTI=ON                 \
        -D LLVM_TARGETS_TO_BUILD="host;AMDGPU" \
        -D LLVM_BINUTILS_INCDIR=/usr/include   \
        -D LLVM_INCLUDE_BENCHMARKS=OFF         \
        -D CLANG_DEFAULT_PIE_ON_LINUX=ON       \
        -D CLANG_CONFIG_FILE_SYSTEM_DIR=/etc/clang \
        -W no-dev -G Ninja ..

  ulimit -s 32768
}

k_build() {
  # Make sure we can compile successfully if the hardware resources is not enough
  # and can cause stopping before completing compiling
  ninja
  ninja
  ninja
}

k_check() {
  rm -f ../projects/compiler-rt/test/tsan/getline_nohang.cpp
  sh -c 'ulimit -c 0 && ninja check-all'
}

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install
  cp bin/FileCheck $KPKG_TMP_DIR/usr/bin

  mkdir -pv $KPKG_TMP_DIR/etc/clang
  for i in clang clang++; do
    echo -fstack-protector-strong > $KPKG_TMP_DIR/etc/clang/$i.cfg
  done
}
