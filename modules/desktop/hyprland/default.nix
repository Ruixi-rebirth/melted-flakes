{ config, lib, pkgs, inputs, ... }:

let
  default_wall = pkgs.writeShellScript "default_wall" ''
    killall dynamic_wallpaper
      if [[ "$GTK_THEME" == "Catppuccin-Frappe-Pink" ]]; then
        ${pkgs.swww}/bin/swww img "${../../theme/catppuccin-dark/common/wall/default.png}" --transition-type random
      elif [[ "$GTK_THEME" == "Catppuccin-Latte-Green" ]]; then
        ${pkgs.swww}/bin/swww img "${../../theme/catppuccin-light/common/wall/default.png}" --transition-type random
      else 
        ${pkgs.swww}/bin/swww img "${../../theme/nord/common/wall/default.png}" --transition-type random
      fi
  '';
in

{
  imports = [ ../../programs/wayland/waybar/hyprland_waybar.nix ];

  programs = {
    dconf.enable = true;
    light.enable = true;
  };

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
    before = [ "default_wall.service" ];
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
