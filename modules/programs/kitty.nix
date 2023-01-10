{ config, pkgs, ... }:

{
  programs = {
    kitty = {
      enable = true;
      environment = { };
      theme = "Catppuccin-Mocha";
      keybindings = { };
      font.name = "jetbrains mono nerd font";
      font.size = 15;
    };
  };
}
