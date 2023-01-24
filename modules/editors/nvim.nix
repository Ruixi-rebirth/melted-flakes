{ config, lib, pkgs, ... }:

let
  install_lsp = pkgs.writeShellScriptBin "install_lsp" ''
      #!/bin/bash 
    if [ ! -d ~/.npm-global ]; then  
             mkdir ~/.npm-global
             npm set prefix ~/.npm-global
      else 
             npm set prefix ~/.npm-global
    fi
    npm i -g npm vscode-langservers-extracted vscode-langservers-extracted typescript typescript-language-server bash-language-server
  '';
in
{
  programs = {
    neovim = {
      enable = true;
      withPython3 = true;
      withNodeJs = true;
      extraPackages = [
      ];
      #-- Plugins --#
      plugins = with pkgs.vimPlugins;[ ];
      #-- --#
    };
  };
  home = {
    packages = with pkgs; [
      #-- LSP --#
      install_lsp
      rnix-lsp
      sumneko-lua-language-server
      gopls
      pyright
      zk
      rust-analyzer
      clang-tools
      #-- format --#
      stylua
      black
      nixpkgs-fmt
      rustfmt
      beautysh
      nodePackages.prettier
      #-- Debug --#
      lldb
    ];
  };

  home.file.".config/nvim/init.lua".source = ./nvim/init.lua;
  home.file.".config/nvim/lua".source = ./nvim/lua;
}
