{ config, pkgs, ... }:
{
  programs = {
    btop = {
      enable = true;
    };
    mako = {
      enable = true;
    };
  };
  home = {
    packages = with pkgs; [
      cava
      dbeaver
      imv
      rofi-wayland
      lazygit
    ];
  };
}
