### Preparing the hard disk (UEFI)
***

* See partitions/drives on the system (find the name of your hard drive)
 ```
 fdisk -l
 ```
* Start the partitioner (fdisk)
```
fdisk /dev/<DEVICE> (substitute <DEVICE> for your device name, example: /dev/sda or /dev/nvme0n1)
```
*  Show current partitions
```
p
```
* Create EFI partition
```
 g (to create an empty GPT partition table)
 n
 enter
 enter
 +500M
 t
 1 (for EFI)
 ```
* Create LVM partition
```
 n
 enter
 enter
 enter
 t
 enter
 43 (for Linux LVM)
```
* Show current partitions again
```
 p
```
* Finalize partition changes
 ```
 w
 ```
