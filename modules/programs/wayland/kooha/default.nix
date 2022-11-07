{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      kooha
    ];
  };
}
