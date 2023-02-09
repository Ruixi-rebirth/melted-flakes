{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  shellHook = ''
    export PS1="\e[0;34m(Git)\$ \e[m" 
  '';
  nativeBuildInputs = with pkgs; [ git ];
}
