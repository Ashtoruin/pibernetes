#!/bin/bash
 
# Install required pi-gen dependencies
sudo apt-get update
sudo apt-get install -yq coreutils quilt parted qemu-user-static debootstrap zerofree zip \
dosfstools libarchive-tools libcap2-bin grep rsync xz-utils file git curl bc \
qemu-utils kpartx gpg pigz

cp main/config pi-gen/config
cd pi-gen
sudo ./build.sh
