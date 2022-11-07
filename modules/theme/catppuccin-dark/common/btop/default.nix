{ config, pkgs, ... }:
{
  programs = {
    btop = {
      settings = {
        color_theme = "catppuccin_mocha";
      };
    };
  };
  home.file.".config/btop/themes/catppuccin_mocha.theme".source = ./theme.nix;
}
