{ config, lib, pkgs, user, impermanence, ... }:

{
  imports =
    [ (import ../../../modules/desktop/dwm/home.nix) ] ++
    [ (import ../../../modules/scripts) ] ++
    (import ../../../modules/shell) ++
    (import ../../../modules/editors) ++
    (import ../../../modules/programs) ++
    # (import ../../../modules/theme/catppuccin-dark) ++
    # (import ../../../modules/theme/catppuccin-light) ++
    (import ../../../modules/theme/nord) ++
    (import ../../../modules/devlop);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };
  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "22.11";
}
