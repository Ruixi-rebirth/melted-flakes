{ lib, pkgs, user, ... }:

{
  home.file.".config/fish/conf.d/nord.fish".text = import ./conf.d/nord_theme.nix;
}
