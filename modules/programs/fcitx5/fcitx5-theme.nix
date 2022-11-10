{ config, lib, pkgs, ... }:
{
  home.file.".config/fcitx5/conf/classicui.conf".source = ./classicui.conf;
  home.file.".config/fcitx5/conf/pinyin.conf".source = ./pinyin.conf;
  home.file.".config/fcitx5/config".source = ./config;
  home.file.".config/fcitx5/profile".source = ./profile;
  home.file.".local/share/fcitx5/themes/Catppuccin/theme.conf".text = import ./theme.nix;
}
