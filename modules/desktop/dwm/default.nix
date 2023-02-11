{ config, lib, pkgs, inputs, ... }:
{
  imports = [ ../../programs/x11/st/st.nix ];
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
