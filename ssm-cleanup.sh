#!/bin/bash

echo -e "
   Cleaning up ...
"

ssm -f remove /mnt/ssm-test vg_ssm
pvremove /dev/vdb1
pvremove /dev/vdb2
yum remove -y system-storage-manager
mv -f /etc/fstab.orig /etc/fstab
parted /dev/vdb rm 1
parted /dev/vdb rm 2
