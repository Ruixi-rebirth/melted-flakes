{ config, lib, pkgs, ... }:
{
  imports = [ ../../programs/waybar.nix ];

   home.packages = with pkgs; [
     Cava
     wallpaper_random
     waybar
    ];
  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs;[
      swaybg
      swayidle
      swaylock-effects
      ];
    };
  };

  xdg.portal = {
   enable = true;
   wlr.enable = true;
   extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
   };

}
