#!/bin/bash -e
set -x

# Get cloud-init
sudo apt update
sudo debconf-set-selections -v <<<"cloud-init cloud-init/datasources multiselect NoCloud, None" 2>/dev/null
sudo apt install -y cloud-init
#sudo debconf-set-selections -v <<<"cloud-init cloud-init/datasources multiselect NoCloud, None" 2>/dev/null; sudo dpkg-reconfigure cloud-init -f noninteractive 2>/dev/null;

# Prepare datasource
#/etc/cloud/cloud.cfg

# Create meta-data
# /boot/meta-data

# Create user-data
# /boot/user-data

# Initialize cloud-init
sudo cloud-init init --local

# Create a script to run per boot
sudo tee /var/lib/cloud/scripts/per-boot/00_run-parts.sh <<'BASH'
#!/bin/bash

# Prevent *.sh from returning itself if there are no matches
shopt -s nullglob

# Run every per-once script
run-parts --regex '.*\.sh$' /boot/per-once

# Rename every per-once script
for f in /boot/per-once/*.sh; do
    mv $f $(dirname $f)/$(basename $f .sh).$(date +%F@%H.%M.%S)
done

# Run every per-boot script
run-parts --regex '.*\.sh$' /boot/per-boot
BASH
sudo chmod +x /var/lib/cloud/scripts/per-boot/00_run-parts.sh

# Create sample per-boot and per-once scripts
sudo mkdir -p /boot/{per-boot,per-once}
sudo tee /boot/per-boot/01_get_ready.sh \
         /boot/per-boot/02_do_it.sh \
         /boot/per-once/01_prepare.sh \
         /boot/per-once/02_install_stuff.sh <<'BASH'
#!/bin/bash

date="$(date +"%x %X")"
script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
script_name="$(basename ${BASH_SOURCE[0]} .sh)"
log_name="$(basename $script_path)"

echo "$date - $script_name" >> /home/pi/${log_name}.out
BASH

echo "Cloud-Init setup is complete."
# vim: et sw=4 ts=4 sts=4 syntax=sh
