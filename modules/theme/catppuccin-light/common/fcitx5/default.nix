{ config, lib, pkgs, ... }:
{
  home.file.".config/fcitx5/conf/classicui.conf".source = ./classicui.conf;
  home.file.".local/share/fcitx5/themes/Catppuccin/theme.conf".text = import ./theme.nix;
}
