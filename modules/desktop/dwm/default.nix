{ config, lib, pkgs, inputs, ... }:
{
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    displayManager.startx.enable = true;
  };
  environment.systemPackages = with pkgs; [
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    betterlockscreen
  ];


}
