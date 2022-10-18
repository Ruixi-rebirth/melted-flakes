{ config, pkgs, ... }:
let
  nur-no-pkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {};
in
{
   home = {                                
     packages = with pkgs; [
       nur.repos.linyinfeng.icalingua-plus-plus
     ];
   };
}
