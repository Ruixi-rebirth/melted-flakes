{ config, lib, pkgs, ... }:
{
  imports = [ ../../programs/x11/st/st.nix ];
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    displayManager.startx.enable = true;
    sessionCommands = ''
      ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
        Xcursor.theme: Catppuccin-Frappe-Dark
      ''}
    '';
  };
  environment.systemPackages = with pkgs; [
    betterlockscreen
  ];
}
