{ disks ? [ "/dev/nvme0n1p1" "/dev/nvme0n1p2" ] }:
{
  disko.devices = {
    disk = {
      nvme0n1p1 = {
        device = builtins.elemAt disks 0;
        type = "disk";
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "ESP";
              start = "1MiB";
              end = "100%";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            }
          ];
        };
      };
      nvme0n1p2 = {
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "luks";
              start = "1MiB";
              end = "100%";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ "--allow-discards" ];
                keyFile = "/tmp/secret.key";
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            }
          ];
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "defaults"
          "size=12G"
          "mode=755"
        ];
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/nix";
              mountOptions = [
                "defaults"
              ];
            };
          };
        };
      };
    };
  };
}
