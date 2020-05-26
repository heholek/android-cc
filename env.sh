#!/bin/bash

set -e 

case ${ARCH} in
    arm64-v8a)
        TARGET=aarch64-linux-android
		;;
    armeabi-v7a)
		TARGET=arm7a-linux-androideabi
		;;
    x86)
		TARGET=i686-linux-android
		;;
	x86_64)
		TARGET=x86_64-linux-android
		;;
esac

export TOOLCHAIN=${ANDROID_NDK_LOCATION}/toolchains/llvm/prebuilt/linux-x86_64
export TARGET=aarch64-linux-android
export AR=${TOOLCHAIN}/bin/${TARGET}${ANDROID_COMPILE_SDK}-ar
export AS=${TOOLCHAIN}/bin/${TARGET}${ANDROID_COMPILE_SDK}-as
export CC=${TOOLCHAIN}/bin/${TARGET}${ANDROID_COMPILE_SDK}-clang
export CXX=${TOOLCHAIN}/bin/${TARGET}${ANDROID_COMPILE_SDK}-clang++
export LD=${TOOLCHAIN}/bin/${TARGET}${ANDROID_COMPILE_SDK}-ld
export RANLIB=${TOOLCHAIN}/bin/${TARGET}${ANDROID_COMPILE_SDK}-ranlib
export STRIP=${TOOLCHAIN}/bin/${TARGET}${ANDROID_COMPILE_SDK}-strip

file ${AR} > /dev/null
file ${AS} > /dev/null
file ${CC} > /dev/null
file ${CXX} > /dev/null
file ${LD} > /dev/null
file ${RANLIB} > /dev/null
file ${STRIP} > /dev/null
