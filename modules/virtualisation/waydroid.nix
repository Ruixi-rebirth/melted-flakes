{ config, pkgs, user, ... }:

{
  virtualisation = {
    waydroid.enable = true;
    lxd.enable = true;
  };
}
