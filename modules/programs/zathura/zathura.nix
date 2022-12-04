{ lib, pkgs, user, ... }:

{
  programs.zathura = {
    enable = true;
  };
  home.file.".config/zathura/zathurarc".source = ./zathurarc;
}
