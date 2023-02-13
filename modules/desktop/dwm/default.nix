{ config, lib, pkgs, user, ... }:
{
  imports = [ ../../programs/x11/st/st.nix ];
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    displayManager = {
      startx.enable = true;
      sessionCommands = ''systemctl --user start dwm-session.target'';
    };
  };
  environment.systemPackages = with pkgs; [
    betterlockscreen
  ];
}
