{ config, pkgs, lib, ... }:
{
  home.file = {
    ".config/polybar/colors.ini".source = ./colors.ini;
    ".config/polybar/config.ini".source = ./config.ini;
    ".config/polybar/modules.ini".source = ./modules.ini;
  };
}
