#!/bin/sh
#cd /nfs/images
image="/nfs/images/2020-08-20-raspios-buster-arm64-lite.img"
start_bytes=($(sudo sfdisk --json $image | jq -r '.partitiontable.partitions | .[].start'))

mount $image -o loop,offset=$(( 512 * ${start_bytes[0]})) /imgtmp
rsync -a /imgtmp/ /nfs/client/boot/
umount /imgtmp
mount $image -o loop,offset=$(( 512 * ${start_bytes[1]})) /imgtmp
rsync -a /imgtmp/ /nfs/client/root/
umount /imgtmp
exit 0
