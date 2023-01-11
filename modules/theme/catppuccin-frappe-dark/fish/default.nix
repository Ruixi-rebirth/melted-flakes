{ lib, pkgs, user, ... }:

{
  home.file.".config/fish/conf.d/latte.fish".text = import ./latte.nix;
}
