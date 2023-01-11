{ config, lib, pkgs, ... }:
{
  imports =
    [
      ./nvidia.nix
      #./vulkan.nix
      # ./hotspot.nix
      ./bluetooth.nix
    ];
}
