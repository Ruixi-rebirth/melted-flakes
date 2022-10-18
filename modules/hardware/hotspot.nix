{ config, lib, pkgs, ... }: 

{
  services.hostapd = {
  enable        = true;
  interface     = "wlp0s20f3";
  hwMode        = "g";
  ssid          = "nix";
  wpaPassphrase = "mysekret";
};
}
