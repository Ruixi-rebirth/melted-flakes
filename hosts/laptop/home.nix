{ config, lib, pkgs, user, impermanence, ... }:

{
  imports = [
    ../../modules/desktop/sway
    ../../modules/desktop/hyprland
    ../../modules/scripts
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
