{ config, pkgs, ... }:
{
  gpg.package = pkgs.gnupg;
  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };
  };
}
