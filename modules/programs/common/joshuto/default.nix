{ pkgs, config, ... }:
{
  home = {
    packages = with pkgs; [
      file
      joshuto
    ];
  };
  home.file.".config/joshuto".source = ./config;
}
