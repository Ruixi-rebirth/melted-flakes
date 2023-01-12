{ config, lib, pkgs, ... }:
{
  home.file.".config/nvim/init.lua".source = ./nvim/init.lua;
  home.file.".config/nvim/lua/ui".source = ./nvim/lua/ui;
  home.file.".config/nvim/lua/core".source = ./nvim/lua/core;
  home.file.".config/nvim/lua/plugins".source = ./nvim/lua/plugins;
}
