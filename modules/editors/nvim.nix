{ config, lib, pkgs, ... }: 

{
  programs={
    neovim={
      enable=true;
      withPython3=true;
      withNodeJs=true;
    };
  };
  home.file.".config/nvim/init.lua".source = ./nvim/init.lua;
  home.file.".config/nvim/lua".source = ./nvim/lua;
}
