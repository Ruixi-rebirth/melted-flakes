{ config, lib, pkgs, ... }:
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-chinese-addons
    ];
  };
  environment.systemPackages = with pkgs; [
    # fcitx5-gtk
    # fcitx5-lua
    # libsForQt5.fcitx5-qt
    # fcitx5-configtool
  ];
}
