{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
    [(import ../../modules/environment/variables.nix)] ++
    [(import ../../modules/desktop/sway/default.nix)] ++
    [(import ../../modules/programs/fcitx5.nix)] ++
    [(import ../../modules/fonts/fonts.nix)] ++
    (import ../../modules/hardware) ++
    (import ../../modules/virtualisation);

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "auto";
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    timeout = 3;
    };
    kernelParams = [
      "quiet"
      "splash"
      "nvidia-drm.modeset=1"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  programs = {
    dconf.enable = true;
    light.enable = true;
  };

}
