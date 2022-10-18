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
      functions = {
        
      };
      shellAliases = {
        nvim = "vi";
        top = "btop";
        l = "ls -ahl";
        ls = "lsd";
        mpv = "env __NV_PRIME_RENDER_OFFLOAD=1 mpv";
        n = "neofeth";
        r = "ranger";
      };
    };
  };
   # home.file.".config/fish/fish_variables".source = ./fish_variables;
   home.file.".config/fish/conf.d/mocha.fish".source = ./conf.d/mocha.fish;
   # home.file.".config/fish/functions".source = ./functions;
}
