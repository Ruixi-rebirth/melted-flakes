{ config, pkgs, ... }:
{
  home.file.".config/cava/config".source = ./config;
  home.file.".config/cava/config1".source = ./config1;
}
