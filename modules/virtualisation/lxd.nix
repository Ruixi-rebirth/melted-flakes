{ config, pkgs, user, ... }:
{
  virtualisation.lxd.enable = true;
  users.users.${user} = {
    extraGroups = [ "lxd" ];
  };
}
