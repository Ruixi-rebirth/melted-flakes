{ config, pkgs, ... }:

{
  programs = {
    kitty = {
      enable = true;
      environment = { };
      keybindings = { };
    };
  };
}
