#!/bin/bash
 
# Install required pi-gen dependencies
sudo apt-get update
sudo apt-get install -yq coreutils quilt parted qemu-user-static debootstrap zerofree zip \
dosfstools libarchive-tools libcap2-bin grep rsync xz-utils file git curl bc \
qemu-utils kpartx gpg pigz

cp main/config pi-gen/config
cd pi-gen
touch ./stage3/SKIP ./stage4/SKIP ./stage5/SKIP
touch ./stage4/SKIP_IMAGES ./stage5/SKIP_IMAGES
sudo ./build.sh
