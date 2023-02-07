{ config, lib, pkgs, inputs, ... }:
let
  swwwInit = pkgs.writeShellScriptBin "swwwInit" ''
     ${pkgs.swww}/bin/swww init
      if [[ "$GTK_THEME" == "Catppuccin-Frappe-Pink" ]]; then
      ${pkgs.swww}/bin/swww img "${../../theme/catppuccin-dark/wall/default.png}" --transition-type random
    elif [[ "$GTK_THEME" == "Catppuccin-Latte-Green" ]]; then
      ${pkgs.swww}/bin/swww img "${../../theme/catppuccin-light/wall/default.png}" --transition-type random
    else 
      ${pkgs.swww}/bin/swww img "${../../theme/nord/wall/default.png}" --transition-type random
    fi
  '';
in
{
  imports = [ ../../programs/waybar/hyprland_waybar.nix ];

  environment.systemPackages = with pkgs; [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    swww
    swaylock-effects
    pamixer
  ];

  systemd.user.services.swww = {
    description = "Efficient animated wallpaper daemon for wayland";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${swwwInit}";
      ExecStop = "${pkgs.swww}/bin/swww kill";
    };
  };


  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

}
