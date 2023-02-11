{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      lazygit
    ];
  };
}
