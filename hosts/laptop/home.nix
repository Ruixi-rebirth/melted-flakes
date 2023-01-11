{ config, lib, pkgs, user, impermanence, ... }:

{
  imports = [
    ../../modules/desktop/sway/home.nix
    ../../modules/desktop/hyprland/home.nix
    ../../modules/scripts/home.nix
  ] ++
  (import ../../modules/shell) ++
  (import ../../modules/editors) ++
  (import ../../modules/programs) ++
  (import ../../modules/theme/catppuccin-frappe-dark) ++
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
