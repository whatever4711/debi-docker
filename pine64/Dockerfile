FROM ubuntu:15.04
MAINTAINER Milo Kim <woogyom.kim@gmail.com>

ENV home /home/pine64
RUN mkdir -p ${home}
WORKDIR ${home}

# Install tools
RUN apt-get update && apt-get install -y \
	wget curl git xz-utils build-essential bc python

# Download mkbootimg
RUN wget https://android.googlesource.com/platform/system/core/+archive/master/mkbootimg.tar.gz
RUN tar xf mkbootimg.tar.gz
ENV PATH ${home}:$PATH

# Download files for building pine64 kernel
RUN git clone --branch a64-v4 --single-branch https://github.com/apritzel/linux.git

# Download ARM64 cross compiler
ENV gcc https://releases.linaro.org/components/toolchain/binaries/latest-5/aarch64-linux-gnu/gcc-linaro-5.3-2016.02-x86_64_aarch64-linux-gnu.tar.xz
RUN wget -q -O gcc-linaro.tar.xz ${gcc}
RUN tar xf ./gcc-linaro.tar.xz && rm gcc-linaro.tar.xz && mv gcc-linaro-* gcc-linaro       
ENV PATH ${home}/gcc-linaro/bin/:$PATH

WORKDIR ${home}/linux

# Download prebuilt ramdisk from Debian daily snapshot
RUN wget https://d-i.debian.org/daily-images/arm64/daily/cdrom/initrd.gz

# Create build script
RUN echo '#!/bin/bash\n\
NUM_CPUS=$(cat /proc/cpuinfo | grep "processor" | wc -l)\n\
JOBS="-j"$NUM_CPUS\n\
if [ ! -f .config ]; then\n\
  make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig\n\
fi\n\
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- $JOBS Image\n\
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- allwinner/sun50i-a64-pine64.dtb allwinner/sun50i-a64-pine64-plus.dtb\n\
mkbootimg --kernel arch/arm64/boot/Image --ramdisk initrd.gz --base 0x40000000 --kernel_offset 0x01080000 --ramdisk_offset 0x20000000 --board Pine64 --pagesize 2048 -o kernel.img'\
>> build.sh

RUN chmod a+x build.sh

