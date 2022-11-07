{ lib, pkgs, user, ... }:

{
  home.file.".config/fish/conf.d/mocha.fish".text = import ./conf.d/mocha_theme.nix;
}
