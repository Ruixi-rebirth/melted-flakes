{ config, lib, pkgs, inputs, ... }:
{
  imports = [ ../../programs/waybar/hyprland_waybar.nix ];

  environment.systemPackages = with pkgs; [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    swww
    swaybg
    swaylock-effects
    pamixer
  ];

  programs = {
    hyprland = {
      enable = true;
    };
  };

  systemd.user.services.swww = {
    description = "Efficient animated wallpaper daemon for wayland";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      ExecStop = "${pkgs.swww}/bin/swww kill";
      Restart = "always";
    };
  };


  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

}
