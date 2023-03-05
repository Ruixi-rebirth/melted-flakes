{ config, lib, pkgs, user, impermanence, ... }:

{
  imports =
    # [ (import ../../../modules/desktop/sway/home.nix) ] ++
    [ (import ../../../modules/desktop/hyprland/home.nix) ] ++
    [ (import ../../../modules/scripts) ] ++
    (import ../../../modules/shell) ++
    (import ../../../modules/editors) ++
    (import ../../../modules/programs/wayland) ++
    (import ../../../modules/theme/catppuccin-dark/wayland) ++
    # (import ../../../modules/theme/catppuccin-light/wayland) ++
    # (import ../../../modules/theme/nord/wayland) ++
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
