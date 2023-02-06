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

  systemd.user.services.swww = {
    Unit = {
      Description = "Swww background";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      ExecStart = "swww init";
      ExecStop = "swww kill";
      Restart = "on-failure";
    };
  };

  programs = {
    hyprland = {
      enable = true;
    };
  };

  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

}
