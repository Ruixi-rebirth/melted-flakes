{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      feh
    ];
  };
}
