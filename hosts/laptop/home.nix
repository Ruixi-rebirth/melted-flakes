{ config, lib, pkgs, user, impermanence, ... }:

{
  imports =
    [ (import ../../modules/desktop/sway/home.nix) ] ++
    [ (import ../../modules/desktop/hyprland/home.nix) ] ++
    [ (import ../../modules/scripts/home.nix) ] ++
    (import ../../modules/shell) ++
    (import ../../modules/editors) ++
    (import ../../modules/programs) ++
    # [ (import ../../modules/environment/sway-variables.nix) ] ++
    [ (import ../../modules/environment/hypr-variables.nix) ] ++
    (import ../../modules/theme) ++
    (import ../../modules/dev_lang);

  home = {
    username = "ruixi";
    homeDirectory = "/home/ruixi";
  };
  programs = {
    home-manager.enable = true;
  };
  home.persistence."/nix/dotfiles" = {
    removePrefixDirectory = true; # for GNU Stow styled dotfile folders
    allowOther = true;
    directories = [
      # fuse mounted from /nix/dotfiles/Firefox/.mozilla to /home/$USERNAME/.mozilla
      "Firefox/.mozilla"
    ];
    files = [
      # "Atom/.atom/config.cson"
      # "Atom/.atom/github.cson"
    ];
  };
  home.stateVersion = "22.11";
}
