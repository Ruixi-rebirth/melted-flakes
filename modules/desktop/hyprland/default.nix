{ config, lib, pkgs, inputs, ... }:

let
  default_wall = pkgs.writeShellScript "default_wall" ''
    killall dynamic_wallpaper
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
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.swww}/bin/swww-daemon
      '';
      ExecStop = "${pkgs.swww}/bin/swww kill";
      Restart = "on-failure";
    };
  };
  systemd.user.services.default_wall = {
    description = "default wallpaper";
    requires = [ "swww.service" ];
    after = [ "swww.service" "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    script = ''${default_wall}'';
    serviceConfig = {
      Type = "oneshot";
      Restart = "on-failure";
    };
  };


  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

}
