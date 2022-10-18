{ config, pkgs, ... }:
{
   home = {                                
     packages = with pkgs; [
       nur.repos.linyinfeng.icalingua-plus-plus
     ];
   };
}
