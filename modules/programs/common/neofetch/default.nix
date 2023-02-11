{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.neofetch ];
  home.file.".config/neofetch/config.conf".text = import ./config.nix;
}
