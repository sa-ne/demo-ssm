# demo-ssm
Quick demo of System Storage Manager (SSM) capabilities

System Storage Manager (SSM) -- provides a command line interface to manage storage in various technologies.  Allows knowledge and usage of one command syntax for multiple storage backends and filesystem types.  

### Installation
Not installed by default, RHEL 7 or 8 only, no RHEL 6 or lower

```
      # yum install -y system-storage-manager
```

### Example: Create filesystem
```
      # ssm -f create --fstype xfs -p vg_ssm -n lv_ssm -s 400M /dev/vdb1 /dev/vdb2 /mnt/ssm-test
```

#### LVM equivalent:
  * Simplifies storage mgmt vs LVM  (1 step vs 5+)
```
# pvcreate /dev/vdb1
# pvcreate /dev/vdb2
# vgcreate vg_ssm /dev/vdb1 /dev/vdb2
# lvcreate -n lv_ssm -L 400M vg_ssm
# mkfs -t xfs /dev/vg_ssm/lv_ssm
# mount -t xfs /dev/vg_ssm/lv_ssm /mnt/ssm-test
```

### Example: Resize

```
      # ssm resize -s +50%FREE /dev/vg_ssm/lv_ssm
```

### Example: Destroy
```
      # ssm -f remove /mnt/ssm-test vg_ssm
      # pvremove /dev/vdb1 /dev/vdb2
```

### Other Examples
Display information about all detected devices, pools, volumes, and snapshots:
```
      # ssm list
```

Check (fsck):
```
      # ssm check <device>
```

Syntax:
```
# ssm create | resize
--fstype xfs|ext4|ext3|btrfs
-s <size> Kk|Mm|Gg|Tt|Pp|Ee|+/-%’N’FREE/USED (also resize)
-p vg name
-n lv name
-f = force
<devices> (also resize but last, after volume)
<mount>
```

### References and Resources
* [Red Hat Documentation - RHEL 7](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/storage_administration_guide/ch-ssm)
