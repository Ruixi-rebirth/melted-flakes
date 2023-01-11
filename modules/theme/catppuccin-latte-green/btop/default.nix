{ config, pkgs, ... }:
{
  programs = {
    btop = {
      settings = {
        color_theme = "catppuccin_latte";
      };
    };
  };
  home.file.".config/btop/themes/catppuccin_latte.theme".source = ./theme.nix;
}
