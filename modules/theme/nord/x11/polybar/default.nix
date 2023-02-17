{ config, pkgs, lib, ... }:
{
  home.file = {
    ".config/polybar" = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink ./polybar;
    };
  };
}
