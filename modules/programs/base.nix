{ config, pkgs, ... }:
{
  programs = {
    btop = {
      enable = true;
    };
    mako = {
      enable = true;
    };
    gnupg.package = pkgs.gnupg;
    gnupg.agent.enable = true;
    gnupg.agent.pinentryFlavor = "gnome3";
  };
  home = {
    packages = with pkgs; [
      cava
      dbeaver
      imv
      rofi-wayland
    ];
  };
}
