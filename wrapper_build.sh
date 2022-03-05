#!/bin/bash
 
# Install required pi-gen dependencies
sudo apt-get -y install coreutils quilt parted qemu-user-static debootstrap zerofree zip \
dosfstools bsdtar libcap2-bin grep rsync xz-utils file git curl bc

export IMG_NAME=edge-raspbian
export RELEASE=buster
export DEPLOY_ZIP=1
export LOCALE_DEFAULT=en_US.UTF-8
export TARGET_HOSTNAME=edge-dev-pi
export KEYBOARD_KEYMAP=us
export KEYBOARD_LAYOUT="English (US)"
export TIMEZONE_DEFAULT=America/New_York
export FIRST_USER_NAME=iot
export FIRST_USER_PASS="${pi_pwd}"
export ENABLE_SSH=1

sudo ./pi-gen/build.sh

