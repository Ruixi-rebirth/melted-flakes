{ config, pkgs, lib, inputs, user, ... }:

{
  qt={
    enable = true;
    platformTheme = "gtk";
    style.name = "gtk2";
  };
}
