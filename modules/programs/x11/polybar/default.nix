{ config, pkgs, lib, user, ... }:
{
  home-manager.users.${user} = {
    services.polybar = {
      enable = true;
      package = pkgs.polybar.override {
        alsaSupport = true;
        pulseSupport = true;
        mpdSupport = true;
      };
      script = "polybar -q main &";
    };
  };
}
