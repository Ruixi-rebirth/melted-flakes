{ config, pkgs, ... }:
{
  programs.gpg.package = pkgs.gnupg;
  services = {
    dbus.packages = [ pkgs.gcr ];
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };
  };
}
