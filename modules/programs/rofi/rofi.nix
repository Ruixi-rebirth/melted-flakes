{ lib, pkgs, user,  ... }:
{
  home = {                                
    packages = with pkgs; [
    rofi-wayland
    ];
  };
   home.file.".config/rofi/off.sh".source = ./rofi/off.sh;
   home.file.".config/rofi/colors.rasi".source = ./rofi/colors.rasi;
   home.file.".config/rofi/launcher.sh".source = ./rofi/launcher.sh;
   home.file.".config/rofi/launcher_theme.rasi".source = ./rofi/launcher_theme.rasi;
   home.file.".config/rofi/powermenu.sh".source = ./rofi/powermenu.sh;
   home.file.".config/rofi/powermenu_theme.rasi".source = ./rofi/powermenu_theme.rasi;
}
