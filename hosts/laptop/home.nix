{ config, lib, pkgs, user, impermanence, ... }:

{
  imports =
    # [ (import ../../modules/desktop/sway/home.nix) ] ++
    [ (import ../../modules/desktop/hyprland/home.nix) ] ++
    [ (import ../../modules/scripts/home.nix) ] ++
    (import ../../modules/shell) ++
    (import ../../modules/editors) ++
    (import ../../modules/programs) ++
    # (import ../../modules/theme/catppuccin-dark) ++
    (import ../../modules/theme/catppuccin-light) ++
    # (import ../../modules/theme/nord) ++
    (import ../../modules/devlop);

  home = {
    username = "ruixi";
    homeDirectory = "/home/ruixi";
  };
  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "22.11";
}
