#!/bin/bash

# The minsdk version to compile for
export ANDROID_PLATFORM=26

for CPU in arm64-v8a armeabi-v7a x86 x86_64; do

	mkdir -p /out/${CPU};

	export ARCH=${CPU}
	export OUT=/out/${CPU}

	source /build/env.sh

	echo "Building for ${CPU}"
	echo "Android Compile SDK: ${ANDROID_COMPILE_SDK}"
	echo "Android Platform (minsdk): ${ANDROID_PLATFORM}"
	echo "Toolchain: ${TOOLCHAIN}"
	echo "CC: ${CC}"
	echo "CXX: ${CXX}"
	echo "LD: ${LD}"	
	echo " "

	/build/build.sh

done
