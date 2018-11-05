# demo-ssm
Quick demo of System Storage Manager (SSM) capabilities

System Storage Manager (SSM) -- Simplifies storage mgmt vs LVM  (1 step vs 5)

```pvcreate + vgcreate + lvcreate + mkfs + mount```

**Not installed by default, RHEL 7 only, no RHEL 6 or lower**

```# yum install -y system-storage-manager```

Create
```
# ssm -f create --fstype xfs -p vg_ssm -n lv_ssm -s 400M /dev/vdb1 /dev/vdb2 /mnt/ssm-test
# df -h /mnt/ssm-test
# grep vg_ssm /proc/mounts>>/etc/fstab
```

LVM equivalent:
```
# pvcreate /dev/vdb1
# pvcreate /dev/vdb2
# vgcreate vg_ssm /dev/vdb1 /dev/vdb2
# lvcreate -n lv_ssm -L 400M vg_ssm
# mkfs -t xfs /dev/vg_ssm/lv_ssm
# mount -t xfs /dev/vg_ssm/lv_ssm /mnt/ssm-test
```

Resize:

```# ssm resize -s +50%FREE /dev/vg_ssm/lv_ssm```

Destroy:
```
# ssm -f remove /mnt/ssm-test vg_ssm
# pvremove /dev/vdb1 /dev/vdb2
Remove fstab entry
```

Display information about all detected devices, pools, volumes, and snapshots:

```# ssm list```

Check (fsck):

```# ssm check <device>```

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


[Reference Documentation](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/storage_administration_guide/ch-ssm)
