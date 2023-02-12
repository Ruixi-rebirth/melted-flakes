{ config, lib, pkgs, user, ... }:
{
  imports = [ ../../programs/x11/st/st.nix ];
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    displayManager = {
      startx.enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    betterlockscreen
  ];
}
