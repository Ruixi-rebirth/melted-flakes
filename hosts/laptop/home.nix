{ config, lib, pkgs, user, ... }:

{
  imports =
    [(import ../../modules/desktop/sway/home.nix)] ++
    (import ../../modules/shell) ++
    (import ../../modules/editors) ++
    (import ../../modules/programs) ++
    (import ../../modules/theme) ++
    (import ../../modules/dev_lang);

  home = {
    username = "ruixi";
    homeDirectory = "/home/ruixi";
  };
  programs = {
    home-manager.enable = true;
  };
  home.stateVersion = "22.05";
}

