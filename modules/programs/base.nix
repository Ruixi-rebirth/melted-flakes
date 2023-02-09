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
      imv
      rofi-wayland
      lazygit
    ];
  };
}
