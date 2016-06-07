#!/bin/bash

DATE=$(date '+%Y%m%d%H%M')
PROG="${0##*/}"
ARGS="${*} default"
DO_RETURN=${SHLVL}
HOME=/home/pine64

trap do_exit SIGINT SIGTERM SIGKILL SIGQUIT SIGABRT SIGSTOP SIGSEGV

do_exit()
{
	STATUS=${1:-0}
	REASON=${2}

	[[ -n "${REASON}" ]] && echo "${REASON}"

	[[ ${DO_RETURN} -eq 1 ]] && return $STATUS || exit $STATUS
}

cd ${HOME}

if [ ! -e "${HOME}/linux-pine64/.git/config" ]
then
	echo "no current linux repository, cloning may take some time."
	git clone --depth 1 --single-branch -b pine64-hacks-1.2 https://github.com/longsleep/linux-pine64
	ARGS="update"
fi

KHOME="${HOME}/linux-pine64"
cd $KHOME

if [ -z "${ARGS##*update*}" ]
then
	make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- mrproper
	git pull

	echo "ctrl-z, run 'git checkout -b \${branch}' here, then fg and 'enter' to continue."
	read waiting
else
	echo "skipping update ('$0 update' to force a new kernel) and starting to build"
fi

if [ ! -e ".config" ]
then
	make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- sun50iw1p1smp_linux_defconfig
	#echo "ctrl-z, and run either 'make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- sun50iw1p1smp_linux_defconfig' or copy a saved config here as .config, run 'make oldconfig', then fg and 'enter' to continue."
	#read waiting
fi

test -e ${KHOME}/arch/arm64/boot/dts/sun50i-a64-pine64-plus.dts || \
	curl -sSL https://github.com/longsleep/build-pine64-image/raw/master/blobs/pine64.dts > ${KHOME}/arch/arm64/boot/dts/sun50i-a64-pine64-plus.dts

CPUS=$(grep processor /proc/cpuinfo | wc -l)
if [ -z "${ARGS##*CPUS=*}" ]
then
	CPUS=${ARGS##*CPUS=}
	CPUS=${CPUS[0]}
	CPUS=${CPUS//[^0-9]/}
fi

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j${CPUS} Image sun50i-a64-pine64-plus.dtb modules

if [ 0 -ne $? ]
then
	echo "Make broke.  fix and resume manually"
	do_exit 1
fi

cd ${HOME}



if [ ! -e "${HOME}/build-pine64-image/.git/config" ]
then
	echo "no current linux repository, cloning may take some time."
	git clone --depth 1 --single-branch -b master https://github.com/longsleep/build-pine64-image.git
fi

#if [ -z "${ARGS##*update*}" ]
#then

#BHOME="${HOME}/build-pine64-image"


make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- modules_install
if [ 0 -ne $? ]
then
	echo "Make (modules_install) broke.  fix and resume manually"
	do_exit 1
fi
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- firmware_install
if [ 0 -ne $? ]
then
	echo "Make (firmware_install) broke.  fix and resume manually"
	do_exit 1
fi

#NUM_CPUS=$(cat /proc/cpuinfo | grep "processor" | wc -l)
#JOBS="-j"$NUM_CPUS
#if [ ! -f .config ]; then
#	make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
#fi
#make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- $JOBS Image
#make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- allwinner/sun50i-a64-pine64.dtb allwinner/sun50i-a64-pine64-plus.dtb
#mkbootimg --kernel arch/arm64/boot/Image --ramdisk initrd.gz --base 0x40000000 --kernel_offset 0x01080000 --ramdisk_offset 0x20000000 --board Pine64 --pagesize 2048 -o kernel.im
