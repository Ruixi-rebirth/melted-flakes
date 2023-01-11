{ lib, pkgs, user, ... }:

{
  home.file.".config/fish/themes/latte.theme".text = import ./latte.nix;
}
