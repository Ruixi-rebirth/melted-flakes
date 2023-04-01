{ config, lib, pkgs, ... }:
{
  # if  wayland.windowManager.a.enable==true then 
  # package = pkgs.emacsGit-nox;
  # else 
  package = pkgs.emacsGit;
  programs.emacs = {
    enable = true;
    package =
      if builtins.hasAttr "wayland" pkgs == true then
        pkgs.emacsGit-nox
      else
        pkgs.emacsGit;
    overrides = self: super: { };
    extraPackages = epkgs: [
      # epkgs.emms
      # epkgs.magit
    ];
    extraConfig = ''

    '';
  };
  services.emacs = {
    enable = true;
    defaultEditor = false;
    client = {
      enable = true;
      arguments = [
        "-c"
      ];
    };
    extraOptions = [
      "-f"
      "exwm-enable"
    ];
    socketActivation.enable = true;
    startWithUserSession = true;
  };
}
