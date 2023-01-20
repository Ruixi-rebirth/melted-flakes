{ lib, pkgs, user, ... }:

{
  home.file.".config/fish/conf.d/nord.fish".text = import ./conf.d/nord_theme.nix;
  home.file.".config/fish/functions/f.fish".text = import ./functions/f.nix;
}
