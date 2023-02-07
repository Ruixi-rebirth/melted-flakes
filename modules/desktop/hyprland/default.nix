{ config, lib, pkgs, inputs, ... }:

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
      ExecStart = ''
        ${pkgs.swww}/bin/swww-daemon
      '';
      ExecStop = "${pkgs.swww}/bin/swww kill";
    };
  };
  systemd.user.services.default_wall = {
    description = "default wallpaper";
    requires = [ "swww.service" ];
    after = [ "swww.service" ];
    serviceConfig = {
      ExecStart = ''${pkgs.default_wall}/bin/default_wall'';
      ExecStop = "${pkgs.swww}/bin/swww kill";
    };
  };


  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

}
