{ config, lib, pkgs, user, impermanence, ... }:

{
  imports =
    [ (import ../../../modules/desktop/bspwm/home.nix) ] ++
    [ (import ../../../modules/scripts) ] ++
    (import ../../../modules/shell) ++
    (import ../../../modules/programs/x11) ++
    (import ../../../modules/theme/nord/x11);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };
  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "22.11";
}
