{ config, lib, pkgs, ... }:

let
  cava-internal = pkgs.writeShellScriptBin "cava-internal" ''
    cava -p ~/.config/cava/config1 | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'
  '';
  wallpaper_random = pkgs.writeShellScriptBin "wallpaper_random" ''
    killall swaybg
    killall dynamic_wallpaper
    swaybg -i $(find ~/Pictures/wallpaper/. -name "*.png" | shuf -n1) -m fill &
  '';
  grimblast_watermark = pkgs.writeShellScriptBin "grimblast_watermark" ''
        FILE=$(date "+%Y-%m-%d"T"%H:%M:%S").png
    # Get the picture from maim
        grimblast --notify --cursor save area ~/Pictures/src.png >> /dev/null 2>&1
    # add shadow, round corner, border and watermark
        convert $HOME/Pictures/src.png \
          \( +clone -alpha extract \
          -draw 'fill black polygon 0,0 0,8 8,0 fill white circle 8,8 8,0' \
          \( +clone -flip \) -compose Multiply -composite \
          \( +clone -flop \) -compose Multiply -composite \
          \) -alpha off -compose CopyOpacity -composite $HOME/Pictures/output.png
    #
        convert $HOME/Pictures/output.png -bordercolor none -border 20 \( +clone -background black -shadow 80x8+15+15 \) \
          +swap -background transparent -layers merge +repage $HOME/Pictures/$FILE
    #
        composite -gravity Southeast "${./watermark.png}" $HOME/Pictures/$FILE $HOME/Pictures/$FILE 
    #
        wl-copy < $HOME/Pictures/$FILE
    #   remove the other pictures
        rm $HOME/Pictures/src.png $HOME/Pictures/output.png
  '';
  grimshot_watermark = pkgs.writeShellScriptBin "grimshot_watermark" ''
        FILE=$(date "+%Y-%m-%d"T"%H:%M:%S").png
    # Get the picture from maim
        grimshot --notify  save area ~/Pictures/src.png >> /dev/null 2>&1
    # add shadow, round corner, border and watermark
        convert $HOME/Pictures/src.png \
          \( +clone -alpha extract \
          -draw 'fill black polygon 0,0 0,8 8,0 fill white circle 8,8 8,0' \
          \( +clone -flip \) -compose Multiply -composite \
          \( +clone -flop \) -compose Multiply -composite \
          \) -alpha off -compose CopyOpacity -composite $HOME/Pictures/output.png
    #
        convert $HOME/Pictures/output.png -bordercolor none -border 20 \( +clone -background black -shadow 80x8+15+15 \) \
          +swap -background transparent -layers merge +repage $HOME/Pictures/$FILE
    #
        composite -gravity Southeast "${./watermark.png}" $HOME/Pictures/$FILE $HOME/Pictures/$FILE 
    #
    # # Send the Picture to clipboard
        wl-copy < $HOME/Pictures/$FILE
    #
    # # remove the other pictures
        rm $HOME/Pictures/src.png $HOME/Pictures/output.png
  '';
  myswaylock = pkgs.writeShellScriptBin "myswaylock" ''
    swaylock  \
           --screenshots \
           --clock \
           --indicator \
           --indicator-radius 100 \
           --indicator-thickness 7 \
           --effect-blur 7x5 \
           --effect-vignette 0.5:0.5 \
           --ring-color 3b4252 \
           --key-hl-color 880033 \
           --line-color 00000000 \
           --inside-color 00000088 \
           --separator-color 00000000 \
           --grace 2 \
           --fade-in 0.3
  '';
  dynamic_wallpaper = pkgs.writeShellScriptBin "dynamic_wallpaper" ''
    killall swaybg
    swaybg -i $(find ~/Pictures/wallpaper/. -name "*.png" | shuf -n1) -m fill &
    OLD_PID=$!
    while true; do
        sleep 120
        swaybg -i $(find ~/Pictures/wallpaper/. -name "*.png" | shuf -n1) -m fill &
        NEXT_PID=$!
        sleep 5
        kill $OLD_PID
        OLD_PID=$NEXT_PID
    done
  '';
  launch_waybar = pkgs.writeShellScriptBin "launch_waybar" ''
    #!/bin/bash
    killall .waybar-wrapped
    SDIR="$HOME/.config/waybar"
    if [[ "$GTK_THEME" == "Catppuccin-Frappe-Pink" ]]; then
      waybar -c "$SDIR"/config -s "$SDIR"/style.css > /dev/null 2>&1 & 
    elif [[ "$GTK_THEME" == "Catppuccin-Latte-Green" ]]; then
      waybar -c "$SDIR"/light_config -s "$SDIR"/light_style.css > /dev/null 2>&1 &
    else 
      waybar -c "$SDIR"/nord_config -s "$SDIR"/nord_style.css > /dev/null 2>&1 &
    fi
  '';
  default_wall = pkgs.writeShellScriptBin "default_wall" ''
    killall swaybg
    killall dynamic_wallpaper
    if [[ "$GTK_THEME" == "Catppuccin-Frappe-Pink" ]]; then
      swaybg -i "${../theme/catppuccin-dark/wall/default.png}" -m fill &
    elif [[ "$GTK_THEME" == "Catppuccin-Latte-Green" ]]; then
      swaybg -i "${../theme/catppuccin-light/wall/default.png}" -m fill &
    else 
      swaybg -i "${../theme/nord/wall/default.png}" -m fill &
    fi
  '';
  border_color = pkgs.writeShellScriptBin "border_color" ''
      function border_color {
      if [[ "$GTK_THEME" == "Catppuccin-Frappe-Pink" ]]; then
        hyprctl keyword general:col.active_border rgb\(ffc0cb\) 
      elif [[ "$GTK_THEME" == "Catppuccin-Latte-Green" ]]; then
          hyprctl keyword general:col.active_border rgb\(C4ACEB\)
      else
          hyprctl keyword general:col.active_border rgb\(81a1c1\)
      fi
    }

    socat - UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do border_color $line; done
  '';
in
{
  home.packages = with pkgs; [
    cava-internal
    wallpaper_random
    grimshot_watermark
    grimblast_watermark
    myswaylock
    dynamic_wallpaper
    default_wall
    launch_waybar
    border_color
  ];
}
