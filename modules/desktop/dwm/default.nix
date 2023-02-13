{ config, lib, pkgs, user, ... }:
{
  imports = [ ../../programs/x11/st/st.nix ];
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    displayManager = {
      startx.enable = true;
      sessionCommands = ''systemctl --user start hyprland-session.target'';
    };
  };
  systemd.user.targets.dwm-session = {
    Unit = {
      Description = "dwm session";
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };
  environment.systemPackages = with pkgs; [
    betterlockscreen
  ];
}
