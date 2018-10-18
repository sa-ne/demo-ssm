#!/bin/bash

yum install -y system-storage-manager
mkdir -p /mnt/ssm-test
cp -f /etc/fstab /etc/fstab.orig
echo -e "
   Create partitions on /dev/vdb

"
parted /dev/vdb mkpart primary 1049kB 263MB
parted /dev/vdb mkpart primary 263MB 525MB

echo -e "
   Now create and mount an LVM filesystem with one step:

	# ssm -f create --fstype xfs -p vg_ssm -n lv_ssm -s 400M /dev/vdb1 /dev/vdb2 /mnt/ssm-test

	LVM equivalent:
	# pvcreate /dev/vdb1
	# pvcreate /dev/vdb2
	# vgcreate vg_ssm /dev/vdb1 /dev/vdb2
	# lvcreate -n lv_ssm -L 400M vg_ssm
	# mkfs -t xfs /dev/vg_ssm/lv_ssm
	# mount -t xfs /dev/vg_ssm/lv_ssm /mnt/ssm-test

"

