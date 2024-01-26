#!/bin/bash

sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade --assume-yes
sudo DEBIAN_FRONTEND=noninteractive apt install --assume-yes wget bc binutils bison dwarves flex gcc git gnupg2 gzip libelf-dev libncurses5-dev libssl-dev make openssl pahole perl-base rsync tar xz-utils build-essential kmod cpio libncurses5-dev libelf-dev libssl-dev dwarves
cd "${GITHUB_WORKSPACE}"

wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.7.2.tar.xz
tar -xvf ./linux-6.7.2.tar.xz

cd linux-6.7.2

cp ../config .config
scripts/config --disable DEBUG_INFO

sudo make -j`nproc` bindeb-pkg

cd ..
mkdir "artifact"
mv ./linux*.deb ./artifact/
