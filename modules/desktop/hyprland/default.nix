{ config, lib, pkgs, ... }:
{
  imports = [ ../../programs/waybar/hyprland_waybar.nix ];

  programs.hyprland = {
    enable = true;
  };

  programs.fish = {
    enable = true;
    loginShellInit = ''
      set TTY1 (tty)
      [ "$TTY1" = "/dev/tty1" ] && exec dbus-run-session Hyprland
    '';
  };

  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  };

}
