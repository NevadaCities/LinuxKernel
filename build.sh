#!/usr/bin/env bash

sudo apt update && sudo apt dist-upgrade -y > /dev/null 2>&1
sudo apt install -y wget build-essential flex bison libssl-dev libelf-dev > /dev/null 2>&1

cd "${GITHUB_WORKSPACE}"

wget https://git.kernel.org/torvalds/t/linux-6.0-rc3.tar.gz > /dev/null 2>&1
tar zxvf ./linux-6.0-rc3.tar.gz > /dev/null 2>&1

cd linux-6.0-rc3

cp ../config .config
scripts/config --disable DEBUG_INFO

CPU_CORES=$(($(grep -c processor < /proc/cpuinfo)*2))
make-kpkg --initrd -j"CPU_CORES" linux-image linux-headers linux-modules

cd ..
mkdir "artifact"
mv ./linux*.deb artifact/
