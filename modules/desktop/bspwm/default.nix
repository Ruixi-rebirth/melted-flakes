{ config, lib, pkgs, user, ... }:
{
  imports = [ ../../programs/x11/polybar ];
  services.xserver = {
    enable = true;
    displayManager = {
      startx.enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    betterlockscreen
    pamixer
    i3lock-fancy
    polybar
  ];
}
