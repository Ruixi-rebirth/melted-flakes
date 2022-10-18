{ config, lib, pkgs, ... }: 
{
  #  environment.systemPackages = [
  #   pkgs.linux-wifi-hotspot
  # ];
  services.create_ap = {
  enable = true;
  settings = {
    INTERNET_IFACE = "enp65s0";
    WIFI_IFACE = "wlp0s20f3";
    SSID = "NixOS";
    PASSPHRASE = "12345678";
  };
};
}
