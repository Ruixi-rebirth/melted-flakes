{ config
, lib
, pkgs
, ...
}:
{
  imports = [ ./swww.nix ];
  config =
    lib.mkIf (config.wayland.windowManager.hyprland.enable) {
      programs.swww.enable = true;
      home.packages =
        if config.programs.swww.enable
        then
          [ ]
        else
          [ pkgs.swaybg ];
      systemd.user.services =
        if (config.programs.swww.enable) then {
          swww = {
            Unit = {
              Description = "Efficient animated wallpaper daemon for wayland";
              PartOf = [ "graphical-session.target" ];
              After = [ "graphical-session.target" ];
            };
            Install.WantedBy = [ "graphical-session.target" ];
            Service = {
              Type = "simple";
              ExecStart = ''
                ${pkgs.swww}/bin/swww-daemon
              '';
              ExecStop = "${pkgs.swww}/bin/swww kill";
              Restart = "on-failure";
            };
          };
          default_wall = {
            Unit = {
              Description = "default wallpaper";
              Requires = [ "swww.service" ];
              After = [ "swww.service" ];
              PartOf = [ "swww.service" ];
            };
            Install.WantedBy = [ "swww.service" ];
            Service = {
              ExecStart = ''${pkgs.swww}/bin/swww img "${../../common/wall/default.png}" --transition-type random'';
              Restart = "on-failure";
              Type = "oneshot";
            };
          };
        }
        else {
          default_wall = {
            Unit = {
              Description = "default wallpaper";
              PartOf = [ "graphical-session.target" ];
            };
            Install.WantedBy = [ "hyprland-session.target" ];
            Service = {
              ExecStart = ''
                ${pkgs.swaybg}/bin/swaybg -i "${../../common/wall/default.png}" -m fill
              '';
              Type = "oneshot";
            };
          };
        };
    };
}
