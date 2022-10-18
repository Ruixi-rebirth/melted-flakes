{ lib, pkgs, user,  ... }:

{
   home.file.".config/fish/conf.d/mocha.fish".source = ./conf.d/mocha_theme.nix;
   home.file.".config/fish/config.fish".source = ./config.nix;
   home.file.".config/fish/fish_variables".source = ./fish_variables.nix;
   home.file.".config/fish/functions".source = ./functions;
}
