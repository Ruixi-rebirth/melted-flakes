{ lib, pkgs, user, ... }:

{
  home.file.".config/zathura/zathurarc".source = ./zathurarc;
}
