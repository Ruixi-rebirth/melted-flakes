{ config, lib, pkgs, ... }: 

{
  services.xserver.videoDrivers = [ "nvidia" ];
}
