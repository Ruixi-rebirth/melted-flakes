{ config, lib, pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package =
      if builtins.hasAttr "wayland" pkgs == true then
        pkgs.emacsPgtk
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
