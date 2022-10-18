{ lib, pkgs, user,  ... }:

{
  programs = {
    fish = {
      enable = true;
      
    #  shellAliases = {
    #   nvim = "vi";
    #   top = "btop";
    #    l = "ls -ahl";
    #    ls = "lsd";
    #    mpv = "env __NV_PRIME_RENDER_OFFLOAD=1 mpv";
    #    n = "neofeth";
    #    r = "ranger";
    #  };
    };
  };
   home.file.".config/fish/conf.d/mocha.fish".source = ./conf.d/mocha.fish;
   home.file.".config/fish/functions/fish_prompt.fish".source = ./functions/fish_prompt.fish;
   home.file.".config/fish/functions/owf.fish".source = ./functions/owf.fish;
   home.file.".config/fish/functions/f.fish".source = ./functions/f.fish;
   home.file.".config/fish/fish_variables".text = import ./fish_variables.nix;
}
