{ config, lib, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    nvidia = {
      open = false;
      modesetting.enable = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        nvidia-vaapi-driver
        vaapiVdpau
        mesa
        libvdpau-va-gl
        libva
      ];
    };
    pulseaudio.support32Bit = true;
  };
  environment = {
    systemPackages = with pkgs; [
      libva-utils
      glxinfo
    ];
  };
}
