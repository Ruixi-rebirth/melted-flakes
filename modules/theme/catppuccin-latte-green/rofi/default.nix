{ lib, pkgs, user, ... }:
{
  home.file.".config/rofi/off.sh".source = ./off.sh;
  home.file.".config/rofi/launcher.sh".source = ./launcher.sh;
  home.file.".config/rofi/launcher_theme.rasi".source = ./launcher_theme.rasi;
  home.file.".config/rofi/powermenu.sh".source = ./powermenu.sh;
  home.file.".config/rofi/powermenu_theme.rasi".source = ./powermenu_theme.rasi;
}
