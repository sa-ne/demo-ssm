## SSM Demo WalkThru:

### Requirements
* ** VM needs small (1GB) second disk (/dev/vdb) **
* Minimum VM: 1vCPU x 1G mem

### WalkThru:
* Setup via ssm-setup.sh
  * Will need root or sudo to install packages
  * Also root/sudo for disk partitions
    * Assumes 2nd 1GB /dev/vdb device
* Setup script will prompt to create new filesystem
  * Talk thru LVM steps (1 vs 5+)
* Show partitions
```
# fdisk -l
```
or
```
# parted -l
```
* Show results
  * PVs were created ```# pvs```
  * VGs were created ```# vgs```
  * LVs were created ```# lvs```
  * Filesystem was created and mounted ```# df -h```
* Resize volume
  * Original device = 1GB, ssm create command = 400MB, result = 450MB
  * Compare df before and after
```
# ssm resize -s +50%FREE /dev/vg_ssm/lv_ssm
```
* Show ssm list
* Show ssm check (fsck)
```
# ssm check /dev/g_ssm/lv_ssm
```
* Cleanup via ssm-cleanup.sh
  * Optional if demo VM is disposable
