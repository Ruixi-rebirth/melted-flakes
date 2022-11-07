{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      cava
    ];
  };

  home.file.".config/cava/config".source = ./cava/config;
  home.file.".config/cava/config1".source = ./cava/config1;
}
