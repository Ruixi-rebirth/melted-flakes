{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      imv
    ];
  };
}
