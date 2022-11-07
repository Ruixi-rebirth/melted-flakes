{ lib, pkgs, user, ... }:

{
  home.file.".config/ranger/colorschemes".source = ./colorschemes;
  home.file.".config/ranger/commands.py".source = ./commands.py;
  home.file.".config/ranger/commands_full.py".source = ./commands_full.py;
  home.file.".config/ranger/plugins".source = ./plugins;
  home.file.".config/ranger/rc.conf".source = ./rc.conf;
  home.file.".config/ranger/rifle.conf".source = ./rifle.conf;
  home.file.".config/ranger/scope.sh".source = ./scope.sh;
}
