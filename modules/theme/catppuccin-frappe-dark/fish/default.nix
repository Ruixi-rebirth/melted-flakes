{ lib, pkgs, user, ... }:

{
  home.file.".config/fish/conf.d/mocha.fish".text = import ./mocha.nix;
}
