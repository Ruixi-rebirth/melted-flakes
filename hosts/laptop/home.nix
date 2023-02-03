{ config, lib, pkgs, user, impermanence, ... }:

{
  imports =
    (if builtins.getEnv "XDG_CURRENT_DESKTOP" == "Hyprland"
    then
      [ (import ../../modules/desktop/hyprland/home.nix) ]
    else
      [ (import ../../modules/desktop/sway/home.nix) ]) ++
    [ (import ../../modules/scripts/home.nix) ] ++
    (import ../../modules/shell) ++
    (import ../../modules/editors) ++
    (import ../../modules/programs) ++
    # (import ../../modules/theme/catppuccin-dark) ++
    # (import ../../modules/theme/catppuccin-light) ++
    (import ../../modules/theme/nord) ++
    (import ../../modules/devlop);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };
  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "22.11";
}
