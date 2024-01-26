#!/bin/bash

# Updating the system
sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt full-upgrade --assume-yes

# Installation of compilation dependencies
sudo DEBIAN_FRONTEND=noninteractive apt install --assume-yes wget bc binutils bison dwarves flex gcc git gnupg2 gzip libelf-dev libncurses5-dev libssl-dev make openssl pahole perl-base rsync tar xz-utils build-essential kmod cpio libncurses5-dev libelf-dev libssl-dev dwarves debhelper

# Download and extract the kernel source code
cd "${GITHUB_WORKSPACE}"
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.7.2.tar.xz
tar -xf ./linux-6.7.2.tar.xz
cd linux-6.7.2

# Copy the kernel configuration to the kernel source folder and optimize the kernel configuration
cp ../config .config
make olddefconfig
scripts/config --disable DEBUG_INFO

# Start compiling
sudo make -j`nproc` bindeb-pkg

# Export Artifact
cd ..
mkdir "artifact"
mv ./linux*.deb ./artifact/
