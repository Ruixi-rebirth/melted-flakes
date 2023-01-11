{ lib, pkgs, user, ... }:
{
  home = {
    packages = with pkgs; [
      rofi-wayland
    ];
  };
}
