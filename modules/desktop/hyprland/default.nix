{ config, lib, pkgs, ... }:
{
  imports = [ ../../programs/waybar/hyprland_waybar.nix ];

  programs.hyprland = {
    enable = true;
  };

  # Automatically on TTY login, see `../../shell/fish/fish.nix`

  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

}
