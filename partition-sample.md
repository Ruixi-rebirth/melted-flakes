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
```
# parted /dev/sda -- mklabel msdos (gpt for uefi)
# parted /dev/sda -- mkpart primary 1MiB -8GiB (512MiB -8GiB for uefi)
# parted /dev/sda -- mkpart primary linux-swap -8GiB 100%

/* extra for UEFI */
# parted /dev/sda -- mkpart ESP fat32 1Mib 512MiB
# parted /dev/sda -- set 3 esp on
```

OR
***


# Defining a helper variable to make the following commands shorter.
```
DISK=/dev/vda
```
# Create partition table
```
parted $DISK -- mklabel gpt
```
# Create a /boot as $DISK-part1
```
parted $DISK -- mkpart ESP fat32 1MiB 512MiB
parted $DISK -- set 1 boot on
```

# Create a /nix as $DISK-part2
```
parted $DISK -- mkpart Nix 512MiB 100%
```

# /boot partition for EFI
```
mkfs.vfat $DISK-part1
```

# /nix partition
```
mkfs.ext4 $DISK-part2
```
Step 3 - Mounting the file systems
Here we do one of the neat tricks, we mount tmpfs instead of a partition and then we mount the partitions we just created.

# Mount your root file system
```
mount -t tmpfs none /mnt
```

# Create directories
```
mkdir -p /mnt/{boot,nix,etc/nixos,var/log}
```

# Mount /boot and /nix
```
mount $DISK-part1 /mnt/boot
mount $DISK-part2 /mnt/nix
```
# Create a directory for persistent directories
```
mkdir -p /mnt/nix/persist/{etc/nixos,var/log}
```
# Bind mount the persistent configuration / logs
```
mount -o bind /mnt/nix/persist/etc/nixos /mnt/etc/nixos
mount -o bind /mnt/nix/persist/var/log /mnt/var/log
```

