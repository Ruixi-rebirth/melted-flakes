{ config, pkgs, ... }:
{
   home = {                                
     packages = with pkgs; [
       dbeaver
     ];
   };
}
