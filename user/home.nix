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
   home.file.".config/waybar/launch_waybar.sh".source = ../user/waybar/launch_waybar.sh;
####watermark
   # home.file.".config/sway/watermark.png".source = ../user/watermark.png;
}
