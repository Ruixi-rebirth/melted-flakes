{ config, pkgs, ... }:

{
  programs = {
    obs-studio.enable = true;
  };
  home.file.".config/obs-studio/themes".source = ./themes;
}
