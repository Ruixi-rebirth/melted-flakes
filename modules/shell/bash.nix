{ pkgs, ... }:
{
  programs = {
    bash = {
      enable = true;
    };
    initExtra = ''
      # if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      #    exec dbus-run-session sway --unsupported-gpu
      #  fi
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
         exec dbus-run-session Hyprland
       fi
    '';
  };
}
