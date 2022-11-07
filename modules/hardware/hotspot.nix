{ config, lib, pkgs, ... }:
{
  services.create_ap = {
    enable = true;
    settings = {
      INTERNET_IFACE = "wlp0s20f3";
      WIFI_IFACE = "wlp0s20f3";
      SSID = "NixOS";
      PASSPHRASE = "12345678";
    };
  };
}
