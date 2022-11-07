{ config, lib, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    nvidia = {
      open = true;
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
        libvdpau-va-gl
        glxinfo
        libva
        mesa
        libva-utils
      ];
    };
    pulseaudio.support32Bit = true;
  };
}
