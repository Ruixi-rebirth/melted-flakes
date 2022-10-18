{ config, pkgs, lib, inputs, user, ... }:

{
  home = {                                
    packages = with pkgs; [
      pkgs.libsForQt5.qtstyleplugins
    ];
  };
  qt={
    enable = true;
    platformTheme = "gtk";
    style.name = "gtk2";
  };
}
