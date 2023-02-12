{ config, lib, pkgs, ... }:

{
  imports = [
    (import ../../environment/dwm-variables.nix)
  ];
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
    ".Xresources".text = ''
      Xcursor.theme: Catppuccin-Frappe-Dark
    '';
    ".xinitrc".text = ''
      if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval $(dbus-launch --exit-with-session --sh-syntax)
      fi
      systemctl --user import-environment DISPLAY XAUTHORITY
      if command -v dbus-update-activation-environment >/dev/null 2>&1; then
       dbus-update-activation-environment DISPLAY XAUTHORITY
      fi
      exec dwm
      [[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
    '';
  };
}
