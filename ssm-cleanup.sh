#!/bin/bash

echo -e "
   Cleaning up ...
"

umount /mnt/ssm-test
wipefs -af /dev/vg_ssm/lv_ssm
ssm -f remove vg_ssm
rm -rf /mnt/ssm-test
pvremove /dev/vdb1
pvremove /dev/vdb2
yum remove -y system-storage-manager
mv -f /etc/fstab.orig /etc/fstab
parted /dev/vdb rm 1
parted /dev/vdb rm 2
