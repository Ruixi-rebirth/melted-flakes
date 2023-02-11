{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    st
    tabbed # Multi-tab support
  ];
}
