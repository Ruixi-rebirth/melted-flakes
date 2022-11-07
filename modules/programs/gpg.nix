{ config, pkgs, ... }:

{
  programs = {
    gnupg.package = pkgs.gnupg;
    gnupg.agent.enable = true;
    gnupg.agent.pinentryFlavor = "gnome3";
  };
}
