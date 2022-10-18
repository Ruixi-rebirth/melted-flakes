{ lib, pkgs, user,  ... }:

{
   # programs.fish={
   #   enable = true;
   #   loginShellInit = ''
   #      set TTY1 (tty)
   #      [ "$TTY1" = "/dev/tty1" ] && exec dbus-run-session sway --unsupported-gpu
   #   '';
   # };

   home.file.".config/fish/conf.d/mocha.fish".text = import ./conf.d/mocha_theme.nix;
   home.file.".config/fish/config.fish".text = import ./config.nix;
   home.file.".config/fish/fish_variables".text = import ./fish_variables.nix;
   home.file.".config/fish/functions".source = ./functions;
}
