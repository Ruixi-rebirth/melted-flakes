{ config, lib, pkgs, inputs, ... }:
{
  imports = [ ../../programs/waybar/hyprland_waybar.nix ];

  environment.systemPackages = with pkgs; [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
  ];
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
