#!/bin/bash -e

BASEDIR=`pwd`

chmod -R u+w output || true
chmod -R u+w build || true
rm -rf output build || true

mkdir output
mkdir build
cd build

echo "Extracting crosstool-NG 1.17.0"
tar xf $BASEDIR/tarballs/crosstool-ng-1.17.0.tar.bz2
echo "Done."

cd crosstool-ng-1.17.0
CTNGDIR=`pwd`
CTNGOUTDIR=$CTNGDIR/x-tools
CTNGTOOLSDIR=$CTNGDIR/.build/arm-linux-gnueabihf/buildtools

echo "Patching crosstool-NG 1.17.0"
for p in `find $BASEDIR/patches -name "*.patch"`; do
    patch -p1 < $p;
done
echo "Done."

echo "Building crosstool-NG 1.17.0"
./configure --prefix=`pwd`/install
make -j6
make install
CTNG_BIN=$CTNGDIR/install/bin/ct-ng
echo "Done."

echo "Building toolchain with crosstool"
cp $BASEDIR/config .config
TARBALLS_DIR=$BASEDIR/tarballs $CTNG_BIN build
echo "Done"

cd ..
export PATH=$CTNGOUTDIR/bin:$CTNGTOOLSDIR/bin:$CTNGDIR/.build/tools/bin:$PATH

echo "Building gcc-cross for chroot"
mkdir gcc-cross-chroot
cd gcc-cross-chroot
OBJDUMP=x86_64-build_unknown-linux-gnu-objdump \
OBJCOPY=x86_64-build_unknown-linux-gnu-objcopy \
NM=x86_64-build_unknown-linux-gnu-nm \
STRIP=x86_64-build_unknown-linux-gnu-strip \
RANLIB=x86_64-build_unknown-linux-gnu-ranlib \
AR=x86_64-build_unknown-linux-gnu-ar \
AS=x86_64-build_unknown-linux-gnu-as \
LD=x86_64-build_unknown-linux-gnu-ld \
CXX=x86_64-build_unknown-linux-gnu-g++ \
CC=x86_64-build_unknown-linux-gnu-gcc \
CFLAGS="-pipe -O2" CXXFLAGS="-pipe -O2" \
CFLAGS_FOR_TARGET="-O2 -mlittle-endian -march=armv6zk  -mcpu=arm1176jzf-s -mtune=arm1176jzf-s -mfpu=vfp -mhard-float" \
CXXFLAGS_FOR_TARGET="-O2 -mlittle-endian -march=armv6zk  -mcpu=arm1176jzf-s -mtune=arm1176jzf-s -mfpu=vfp -mhard-float" \
LDFLAGS_FOR_TARGET="-Wl,-EL" \
$CTNGDIR/.build/src/gcc-linaro-4.6-2012.10/configure \
--build=arm-linux-gnueabihf --host=arm-linux-gnueabihf \
--target=arm-linux-gnueabihf --prefix=/usr --with-sysroot=/ \
--with-build-sysroot=$CTNGOUTDIR/arm-linux-gnueabihf/sysroot \
--enable-languages=c,c++ --with-arch=armv6zk --with-cpu=arm1176jzf-s \
--with-tune=arm1176jzf-s --with-fpu=vfp --with-float=hard \
--with-pkgversion=i"crosstool-NG 1.17.0" --enable-__cxa_atexit \
--disable-libmudflap --disable-libgomp --disable-libssp \
--disable-libquadmath --disable-libquadmath-support \
--with-gmp=$CTNGTOOLSDIR --with-mpfr=$CTNGTOOLSDIR \
--with-mpc=$CTNGTOOLSDIR --with-ppl=$CTNGTOOLSDIR \
--with-cloog=$CTNGTOOLSDIR --with-libelf=$CTNGTOOLSDIR \
--with-host-libstdcxx="-static-libgcc -Wl,-Bstatic,-lstdc++,-Bdynamic -lm -L$CTNGTOOLSDIR/lib -lpwl" \
--enable-threads=posix --enable-target-optspace --enable-linker-build-id \
--disable-nls --enable-c99 --enable-long-long --disable-bootstrap \
--disable-libstdc++-v3 --program-suffix=-4.6 --disable-libgcc \
--enable-multiarch --libexecdir=/usr/lib --without-included-gettext \
--with-gxx-include-dir=/usr/include/c++/4.6 --libdir=/usr/lib
make -j6 all
DESTDIR=$BASEDIR/output make -j6 install
cd ..
echo "Done."

echo "Building binutils-cross for chroot"
mkdir binutils-cross-chroot
cd binutils-cross-chroot
OBJDUMP=x86_64-build_unknown-linux-gnu-objdump \
OBJCOPY=x86_64-build_unknown-linux-gnu-objcopy \
NM=x86_64-build_unknown-linux-gnu-nm \
STRIP=x86_64-build_unknown-linux-gnu-strip \
RANLIB=x86_64-build_unknown-linux-gnu-ranlib \
AR=x86_64-build_unknown-linux-gnu-ar \
AS=x86_64-build_unknown-linux-gnu-as \
LD=x86_64-build_unknown-linux-gnu-ld \
CXX=x86_64-build_unknown-linux-gnu-g++ \
CC=x86_64-build_unknown-linux-gnu-gcc \
CFLAGS="-pipe -O2" CXXFLAGS="-pipe -O2" \
$CTNGDIR/.build/src/binutils-2.22/configure --build=arm-linux-gnueabihf \
--host=arm-linux-gnueabihf --target=arm-linux-gnueabihf --prefix=/usr \
--disable-werror --enable-ld=default --enable-gold \
--with-pkgversion="crosstool-NG 1.17.0" --disable-nls --with-float=hard \
--with-build-sysroot=$CTNGOUTDIR/arm-linux-gnueabihf/sysroot \
--with-sysroot=/ --enable-shared --enable-plugins --enable-multiarch
make -j6
DESTDIR=$BASEDIR/output make install
cd ..
echo "Done."

cd $BASEDIR/output

echo "Removing unneeded files"
rm -rf usr/arm-linux-gnueabihf
rm -rf usr/share
rm -rf usr/include
mkdir -p lib/x86_64-linux-gnu
mv usr/lib/libbfd-2.22.so lib/x86_64-linux-gnu
mv usr/lib/libopcodes-2.22.so lib/x86_64-linux-gnu
rm -f usr/lib/*.a usr/lib/*.la usr/lib/*.so
rm -rf usr/lib/ldscripts
rm -rf usr/lib/gcc/arm-linux-gnueabihf/4.6/include*
rm -rf usr/lib/gcc/arm-linux-gnueabihf/4.6/install-tools
rm -rf usr/lib/gcc/arm-linux-gnueabihf/4.6/plugin
rm -f usr/lib/gcc/arm-linux-gnueabihf/4.6/liblto_plugin.la
rm -f usr/lib/gcc/arm-linux-gnueabihf/4.6/liblto_plugin.so
rm -f usr/lib/gcc/arm-linux-gnueabihf/4.6/liblto_plugin.so.0
rm -f usr/bin/c++-4.6
rm -f usr/bin/arm-linux-gnueabihf-c++-4.6
rm -f usr/bin/ld
echo "Done."

echo "Stripping binaries"
x86_64-build_unknown-linux-gnu-strip usr/bin/*
x86_64-build_unknown-linux-gnu-strip usr/lib/gcc/arm-linux-gnueabihf/4.6/*
x86_64-build_unknown-linux-gnu-strip lib/x86_64-linux-gnu/*
echo "Done."

echo "Building tarball"
tar --owner=root --group=root -cjf ../toolchain-chroot-x86_64.tar.bz2 .
echo "Done."
