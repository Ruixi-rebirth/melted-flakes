{ pkgs, ... }:
{
  programs = {
    fish = {
      enable = true;
      loginShellInit = ''
        set TTY1 (tty)
        [ "$TTY1" = "/dev/tty1" ] && exec dbus-run-session sway --unsupported-gpu

        set -g fish_greeting
      '';
    };
  };
}
