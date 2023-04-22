{ config
, lib
, pkgs
, ...
}:
{
  options.programs = {
    swww = {
      enable = lib.mkEnableOption (lib.mdDoc ''
        swww 
      '');
    };
  };
  config =
    let
      cfg = config.programs.swww;
    in
    lib.mkIf cfg.enable {
      home.packages = [
        pkgs.swww
      ];
    };
}
