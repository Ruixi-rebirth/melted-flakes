{ config, lib, pkgs, ... }: 

{
  services.hostapd = {
  enable        = true;
  interface     = "wlan-ap0";
  hwMode        = "g";
  ssid          = "nix";
  wpaPassphrase = "mysekret";
};
}
