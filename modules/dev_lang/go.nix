{ config, lib, pkgs, ... }:

{
  programs = {
    go = {
      enable = true;
    };
  };
  home.file.".config/go/env".source = ./go/env;
}
