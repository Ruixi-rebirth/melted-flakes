{ lib, pkgs, user,  ... }:

{
   programs.fish.enable = true;
   home.file.".config/fish/conf.d/mocha.fish".text = import ./conf.d/mocha_theme.nix;
   home.file.".config/fish/config.fish".text = import ./config.nix;
   home.file.".config/fish/fish_variables".text = import ./fish_variables.nix;
   home.file.".config/fish/functions".source = ./functions;
}
