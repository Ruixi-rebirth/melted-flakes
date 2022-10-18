{ lib, pkgs, user,  ... }:

{
   home.file.".config/fish/conf.d/mocha.fish".source = ./conf.d/mocha.fish;
   home.file.".config/fish/functions/fish_prompt.fish".source = ./functions/fish_prompt.fish;
   home.file.".config/fish/functions/owf.fish".source = ./functions/owf.fish;
   home.file.".config/fish/functions/f.fish".source = ./functions/f.fish;
   home.file.".config/fish/fish_variables".text = import ./fish_variables.nix;
}
