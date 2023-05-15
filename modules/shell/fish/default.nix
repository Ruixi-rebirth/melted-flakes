{ lib, pkgs, user, ... }:

{
  programs.fish = {
    enable = true;
    loginShellInit = ''
    '';
  };
  home.file.".config/fish/fish_variables".text = import ./fish_variables.nix;
  home.file.".config/fish/functions/l.fish".text = import ./functions/l.nix;
  home.file.".config/fish/functions/n.fish".text = import ./functions/n.nix;
  home.file.".config/fish/functions/r.fish".text = import ./functions/r.nix;
  home.file.".config/fish/functions/ls.fish".text = import ./functions/ls.nix;
  home.file.".config/fish/functions/nf.fish".text = import ./functions/nf.nix;
  home.file.".config/fish/functions/vi.fish".text = import ./functions/vi.nix;
  home.file.".config/fish/functions/top.fish".text = import ./functions/top.nix;
  home.file.".config/fish/functions/owf.fish".text = import ./functions/owf.nix;
  home.file.".config/fish/functions/xdg-get.fish".text = import ./functions/xdg-get.nix;
  home.file.".config/fish/functions/xdg-set.fish".text = import ./functions/xdg-set.nix;
  home.file.".config/fish/functions/fish_prompt.fish".source = ./functions/fish_prompt.fish;
}
