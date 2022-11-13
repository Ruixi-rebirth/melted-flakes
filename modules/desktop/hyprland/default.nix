{ config, lib, pkgs, ... }:
{
  imports = [ ../../programs/waybar/hyprland_waybar.nix ];

  programs.hyprland = {
    enable = true;
  };

  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  };

}
