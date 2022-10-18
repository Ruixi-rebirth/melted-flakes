{ config, pkgs, ... }:
let
  nur-no-pkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {};
in
{
    imports = lib.attrValues nur-no-pkgs.repos.moredhel.hmModules.modules;
   home = {                                
     packages = with pkgs; [
       icalingua-plus-plus
     ];
   };
}
