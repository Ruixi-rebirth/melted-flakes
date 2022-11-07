{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      rofi
    ];
  };
}
