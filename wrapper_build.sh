#!/bin/bash
 
# Install required pi-gen dependencies
sudo apt-get -y install coreutils quilt parted qemu-user-static debootstrap zerofree zip \
dosfstools bsdtar libcap2-bin grep rsync xz-utils file git curl bc

cp config pi-gen/config
cd pi-gen
sudo ./build.sh
