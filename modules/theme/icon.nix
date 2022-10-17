{ config, pkgs, lib, inputs, user, ... }:

{
  home = {                                
    packages = with pkgs; [
      papirus-icon-theme
    ];
  };
}
