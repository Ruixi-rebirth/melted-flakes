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
              };
            }
          ];
        };
      };
      nvme0n1p2 = {
        device = builtins.elemAt disks 1;
        type = "disk";
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "nix";
              start = "1MiB";
              end = "100%";
              part-type = "primary";
              bootable = true;
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/nix";
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
  };
}
