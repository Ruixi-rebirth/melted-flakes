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
 
 
 USE Terminal: `Parted`
 # parted /dev/sda -- mklabel msdos (gpt for uefi)
# parted /dev/sda -- mkpart primary 1MiB -8GiB (512MiB -8GiB for uefi)
# parted /dev/sda -- mkpart primary linux-swap -8GiB 100%

/* extra for UEFI */
# parted /dev/sda -- mkpart ESP fat32 1Mib 512MiB
# parted /dev/sda -- set 3 esp on
