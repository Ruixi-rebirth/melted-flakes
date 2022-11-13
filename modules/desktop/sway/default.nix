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

  programs.fish = {
    loginShellInit = ''
      set TTY1 (tty)
      [ "$TTY1" = "/dev/tty1" ] && exec dbus-run-session sway --unsupported-gpu
    '';
  };

  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  };

}
