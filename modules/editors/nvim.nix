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
        #-- LSP --#
        install_lsp
        pkgs.rnix-lsp
        pkgs.sumneko-lua-language-server
        pkgs.gopls
        pkgs.pyright
        pkgs.zk
        pkgs.rust-analyzer
        pkgs.clang-tools
        #-- format --#
        pkgs.stylua
        pkgs.black
        pkgs.nixpkgs-fmt
        pkgs.rustfmt
        pkgs.beautysh
        pkgs.nodePackages.prettier
        #-- Debug --#
        pkgs.lldb
        pkgs.vscode-extensions.llvm-org.lldb-vscode
      ];
      #-- Plugins --#
      plugins = with pkgs.vimPlugins;[ ];
      #-- --#
    };
  };
  home.file.".config/nvim/init.lua".source = ./nvim/init.lua;
  home.file.".config/nvim/lua".source = ./nvim/lua;
}
