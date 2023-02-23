{ config, pkgs, lib, user, ... }:
{
  # home-manager.users.${user} = {
  #   services.polybar = {
  #     enable = true;
  #     package = pkgs.polybar.override {
  #       alsaSupport = true;
  #       pulseSupport = true;
  #       mpdSupport = true;
  #     };
  #     script = "sleep 2s;polybar -q main &";
  #   };
  # };
  environment.systemPackages = with pkgs; [
    polybarFull
  ];

}
