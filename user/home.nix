{ lib, pkgs, user,  ... }:
{
####ranger
   home.file.".config/ranger/colorschemes".source = ../user/ranger/colorschemes;
   home.file.".config/ranger/commands.py".source = ../user/ranger/commands.py;
   home.file.".config/ranger/commands_full.py".source = ../user/ranger/commands_full.py;
   home.file.".config/ranger/rc.conf".source = ../user/ranger/rc.conf;
   home.file.".config/ranger/rifle.conf".source = ../user/ranger/rifle.conf;
   home.file.".config/ranger/scope.sh".source = ../user/ranger/scope.sh;
####mpv
   home.file.".config/mpv/mpv.conf".source = ../user/mpv/mpv.conf;
   home.file.".config/mpv/input.conf".source = ../user/mpv/input.conf;
   # home.file.".config/mpv/scripts/file-browser.lua".source = ../user/mpv/scripts/file-browser.lua;
####zathura
   home.file.".config/zathura/zathurarc".source = ../user/zathura/zathurarc;
####fish 
   home.file.".config/fish/config.fish".source = ../user/fish/config.fish;
   home.file.".config/fish/fish_variables".source = ../user/fish/fish_variables;
   home.file.".config/fish/conf.d/mocha.fish".source = ../user/fish/conf.d/mocha.fish;
   home.file.".config/fish/functions".source = ../user/fish/functions;
####waybar
   home.file.".config/waybar/Cava.sh".source = ../user/waybar/Cava.sh;
   home.file.".config/waybar/launch_waybar.sh".source = ../user/waybar/launch_waybar.sh;
   home.file.".config/waybar/wallpaper_random.sh".source = ../user/waybar/wallpaper_random.sh;
####grimshot
   home.file.".config/sway/grimshot.sh".source = ../user/sway/grimshot.sh;
   home.file.".config/sway/grimshot_watermark.sh".source = ../user/sway/grimshot_watermark.sh;
   home.file.".config/sway/watermark.png".source = ../user/sway/watermark.png;
   home.file.".config/sway/dynamic_wallpaper.sh".source = ../user/sway/dynamic_wallpaper.sh;
####swayidle
   home.file.".config/sway/swaylock.sh".source = ../user/sway/swaylock.sh;
}
