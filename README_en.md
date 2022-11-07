## How to install ?
0. Partitioning and formatting partitions is done by yourself !
1. nixos-generate-config --root /mnt 
2.
```bash
$ git clone  https://github.com/Ruixi-rebirth/nixos-config.git /mnt/etc/nixos/ 

$ cd /mnt/etc/nixos/nixos-config && rm -rf .git 

$ cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/nixos-config/hosts/laptop/hardware-configuration.nix

$ nixos-install --flake .#laptop
```
