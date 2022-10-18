{ lib, pkgs, user,  ... }:

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
   home.file.".config/fish/fish_variables".source = ./fish_variables;
   home.file.".config/fish/conf.d/mocha.fish".source = ./conf.d/mocha.fish;
   home.file.".config/fish/functions".source = ./functions;
}
