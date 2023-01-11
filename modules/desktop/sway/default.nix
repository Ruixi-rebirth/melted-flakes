{ config, lib, pkgs, ... }:
{
  imports = [ ../../programs/waybar/sway_waybar.nix ];

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs;[
        swaybg
        swayidle
        swaylock-effects
        pamixer
      ];
    };
  };

  # Automatically on TTY login, see `../../shell/fish/fish.nix`

  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  };

}
