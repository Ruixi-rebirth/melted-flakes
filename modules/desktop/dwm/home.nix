{ config, lib, pkgs, ... }:

{
  imports = [
    (import ../../environment/dwm-variables.nix)
  ];
  systemd.user.targets.dwm-session = {
    Unit = {
      Description = "dwm session";
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };
  programs = {
    bash = {
      initExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
           exec  startx
        fi
      '';
    };
  };
  home.file = {
    ".xinitrc".text = ''
      if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval $(dbus-launch --exit-with-session --sh-syntax)
      fi
      systemctl --user import-environment DISPLAY XAUTHORITY
      if command -v dbus-update-activation-environment >/dev/null 2>&1; then
       dbus-update-activation-environment DISPLAY XAUTHORITY
      fi
       ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
         Xcursor.theme: Catppuccin-Frappe-Dark
        ''}
      exec dwm 
    '';
  };
}
