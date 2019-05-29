#!/bin/bash

TextReset='\033[0m'
TextGreen='\033[32m'
TextBlue='\033[34m'
TextLightGrey='\033[37m'
TextBold='\033[1m'

FormatTextPause="$TextReset $TextLightGrey"  # Pause & continue
FormatTextCommands="$TextReset $TextGreen" # Commands to execute
FormatTextSyntax="$TextReset $TextBlue $TextBold" # Command Syntax & other text

# Place before command line to reset text format
FormatRunCommand="echo -e $TextReset"

# Reset text if script exits abnormally
trap 'echo -e $TextReset;exit' 1 2 3 15

clear

# Install and initial config
echo -e $FormatTextSyntax "
   Installing and configuring system

"
$FormatRunCommand
yum install -y system-storage-manager
mkdir -p /mnt/ssm-test
cp -f /etc/fstab /etc/fstab.orig
fdisk -l /dev/vdb || (echo ERROR: missing device = /dev/vdb! Aborting. & exit 1)

echo -e $FormatTextSyntax "
   Create partitions on /dev/vdb

"
$FormatRunCommand
parted /dev/vdb mkpart primary 1049kB 263MB
parted /dev/vdb mkpart primary 263MB 525MB
fdisk -l /dev/vdb
partprobe

echo -e $FormatTextSyntax "
   Now create and mount an LVM filesystem with one step:
"
echo -e $FormatTextCommands "
	# ssm -f create --fstype xfs -p vg_ssm -n lv_ssm -s 400M /dev/vdb1 /dev/vdb2 /mnt/ssm-test

	LVM equivalent:
	# pvcreate /dev/vdb1
	# pvcreate /dev/vdb2
	# vgcreate vg_ssm /dev/vdb1 /dev/vdb2
	# lvcreate -n lv_ssm -L 400M vg_ssm
	# mkfs -t xfs /dev/vg_ssm/lv_ssm
	# mount -t xfs /dev/vg_ssm/lv_ssm /mnt/ssm-test

"
$FormatRunCommand
read -p "Press any key to create filesystem with SSM ... " NULL
echo ""
ssm -f create --fstype xfs -p vg_ssm -n lv_ssm -s 400M /dev/vdb1 /dev/vdb2 /mnt/ssm-test
echo ""
df -h
