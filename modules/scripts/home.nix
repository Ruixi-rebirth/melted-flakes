{ config, lib, pkgs, ...}:

let
  Cava = pkgs.writeShellScriptBin "Cava" ''
    #!/bin/bash
    cava -p ~/.config/cava/config1 | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'
  '';
   wallpaper_random= pkgs.writeShellScriptBin "wallpaper_random" ''
    #!/bin/bash
    is_swaybg_ServerExist=`ps -ef|grep -m 1 swaybg|grep -v "grep"|wc -l`
    if [ "$is_swaybg_ServerExist" = "0" ]; then
      echo "swaybg_server not found" > /dev/null 2>&1
#	exit;
    elif [ "$is_swaybg_ServerExist" = "1" ]; then
      killall swaybg
    fi
    swaybg -i $(find ~/Pictures/wallpaper/. -name "*.png" | shuf -n1) -m fill &
  '';
in 
{
   home.packages = with pkgs; [
     Cava
     wallpaper_random
    ];
}