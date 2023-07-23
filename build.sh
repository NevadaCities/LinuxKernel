#!/usr/bin/env bash

sudo apt update && sudo apt dist-upgrade -y
sudo apt install -y wget build-essential flex bison libssl-dev libelf-dev
cd "${GITHUB_WORKSPACE}"

wget https://git.kernel.org/torvalds/t/linux-6.0-rc3.tar.gz > /dev/null 2>&1
tar zxvf ./linux-6.0-rc3.tar.gz > /dev/null 2>&1

cd linux-6.0-rc3

cp ../config .config
scripts/config --disable DEBUG_INFO

sudo make deb-pkg

cd ..
mkdir "artifact"
mv ./linux*.deb artifact/
