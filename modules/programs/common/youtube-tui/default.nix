{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      youtube-tui
    ];
  };
}
