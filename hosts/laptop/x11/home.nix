{ config, lib, pkgs, user, impermanence, ... }:

{
  imports =
    [ (import ../../../modules/desktop/dwm/home.nix) ] ++
    [ (import ../../../modules/scripts) ] ++
    (import ../../../modules/shell) ++
    (import ../../../modules/editors) ++
    (import ../../../modules/programs/x11) ++
    (import ../../../modules/theme/dwm) ++
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
